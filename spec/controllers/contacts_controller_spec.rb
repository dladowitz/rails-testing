require "spec_helper"

describe ContactsController do
  before :each do
    @erik    = create(:contact, firstname: "Erik",    lastname: "Lehnsherr")
    @charles = create(:contact, firstname: "Charles", lastname: "Xavier")
  end

  describe "Administrator Access" do
    before :each do
      user = create(:admin)
      session[:user_id] = user.id
    end

    describe "GET #index" do
      context "with params[:letter]" do
        it "populates an array of contacts starting with the letter" do
          get :index, letter: "X"
          expect(assigns(:contacts)).to match_array [@charles]
        end

        it "renders the :index template" do
          get :index, letter: "X"
          expect(response).to render_template :index
        end
      end

      context "without params [:letter]" do
        it "populates an array of all contats" do
          get :index
          expect(assigns(:contacts)).to match_array [@erik, @charles]
        end

        it "renders the :index template" do
          get :index
          expect(response).to render_template :index
        end
      end
    end

    describe "Get #show" do
      it "assigns the requested contact to @contatct" do
        get( :show, { id: @charles } )
        expect(assigns(:contact)).to eq @charles
      end

      it "renders the :show template" do
        get :show,  id: @charles
        expect(response).to render_template :show
      end
    end

    describe "GET #new" do
      it "assigns a new Contact to @contact" do
        get :new
        expect(assigns(:contact)).to be_a_new Contact
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "GET #edit" do
      it "assigns the requested contact to @contact" do
        get :edit, id: @charles
        expect(assigns(:contact)).to eq @charles
      end

      it "renders the :edit template" do
        get :edit, id: @charles
        expect(response).to render_template :edit
      end
    end

    describe "POST #create" do
      before :each do
        @phones = [attributes_for(:phone), attributes_for(:phone), attributes_for(:phone)]
      end

      context "with valid attributes" do
        it "saves the new contact in the database" do
          expect{ post :create, contact: attributes_for(:contact, phones_attributes: @phones) }.to change(Contact, :count).by(1)
        end

        it "redirects to contacts#show" do
          post :create, contact: attributes_for(:contact, phones_attributes: @phones)
          expect(response).to redirect_to contact_path(assigns(:contact))
        end
      end

      context "with invalid attributes" do
        it "does not save the new contact in the database" do
          expect{ post :create, contact: attributes_for(:invalid_contact) }.to_not change(Contact, :count).by(1)
        end
        it "re-renders the :new template" do
          post :create, contact: attributes_for(:invalid_contact)
          expect(response).to render_template :new
        end

      end
    end

    describe "PATCH #update" do
      # before :each do
      #   @contact = create(:contact, firstname: "Jean", lastname: "Gray")
      # end

      context "with valid attributes" do
        it "locates the correct contact" do
          patch :update, id: @charles, contact: attributes_for(:contact)
          expect(assigns(:contact)).to eq(@charles)
        end

        it "changes @contact's attributes" do
          patch :update, id: @charles, contact: {lastname: "Marko"}
          expect(@charles.reload.lastname).to eq "Marko"
        end

        it "redirects to the updated contact" do
          patch :update, id: @charles, contact: {lastname: "Marko"}
          expect(response).to redirect_to contact_path(@charles)
        end
      end

      context "with invalid attributes" do
        it "does not update the contact" do
          patch :update, id: @charles, contact: {lastname: nil}
          expect(@charles.reload.lastname).to eq "Xavier"
        end

        it "re-renders the :edit template" do
          patch :update, id: @charles, contact: { lastname: nil }
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      it "deletes the contact from the database" do
        expect{ delete :destroy, id: @charles }.to change(Contact, :count).by(-1)
      end

      it "redirects to the users#index" do
        delete :destroy, id: @charles
        expect(response).to redirect_to contacts_path
      end
    end

    describe "Patch hide_contact" do
      it "marks the contact as hidden" do
        patch :hide_contact, id: @charles
        expect(@charles.reload.hidden?).to be_true
      end

      it "redirects to contacts#index" do
        patch :hide_contact, id: @charles
        expect(response).to redirect_to contacts_path
      end
    end
  end

  describe "Editor Access" do
    before :each do
      @user = create(:editor)
      session[:user_id] = @user.id
    end

    describe "PATCH #update" do
      it "should update attributes on the correct contact" do
        patch :update, id: @charles, contact: { firstname: "Scott" }
        expect(@charles.reload.firstname).to eq "Scott"
      end
    end

  end

  describe "Regular User Access" do
    before :each do
      @user = create(:user)
      session[:user_id] = @user.id
    end

    describe "PATCH #update" do
      it "should not update the contact" do
        patch :update, id: @erik, contact: attributes_for(:contact)
        expect(@erik.reload.firstname).to eq "Erik"
      end

      it "should have an error on the flash" do
        patch :update, id: @erik, contact: attributes_for(:contact)
        expect(flash[:error]).to eq "Must be admin or editor to edit contacts"
      end
    end
  end


  describe "Guest Access" do

    describe "GET #index" do
      context "with params[:letter] passed in" do
        it "gets an array of contacts who's last name start with the params[:letter]" do
          get :index, letter: "X"
          expect(assigns(:contacts)).to match_array [@charles]
        end

        it "renders the index template" do
          get :index, letter: "X"
          expect(response).to render_template :index
        end
      end

      context "with params[:letter] not passed in" do
        it "gets an array of all contacts in the database" do
          get :index
          expect(assigns(:contacts)).to match_array [@erik, @charles]
        end
      end
    end

    describe "GET #show" do
      it "finds the correct contact in the database" do
        get :show, id: @erik
        expect(assigns(:contact)).to eq @erik
      end

      it "renders the show template" do
        get :show, id: @erik
        expect(response).to render_template :show
      end
    end

    describe "GET #new" do
      it "requires login" do
        get :new
        expect(response).to redirect_to login_url
      end
    end

    describe "GET#edit" do
      it "requires login" do
        get :edit, id: @erik
        expect(response).to redirect_to login_url
      end
    end

    describe "POST #create" do
      it "requires login" do
        post :create, contact: attributes_for(:contact)
        expect(response).to redirect_to login_url
      end
    end

    describe "PUT #update" do
      it "requires login" do
        put :update, id: @erik, contact: attributes_for(:contact)
        expect(response).to redirect_to login_url
      end
    end

    describe "DELETE #destroy" do
      it "requires login" do
        delete :destroy, id: @erik
        expect(response).to redirect_to login_url
      end
    end
  end
end
