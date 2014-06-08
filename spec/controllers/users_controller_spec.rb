require "spec_helper"

describe UsersController do
  describe "User Access" do
    before :each do
      @user = create(:user)
      session[:user_id] = @user.id
    end

    describe "GET #index" do
      it "collects users into @users" do
        user = create(:user)

        get :index
        expect(assigns(:users)).to match_array [@user, user]
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    it "GET #new denies access" do
      get :new
      expect(response).to redirect_to login_url
    end

    it "POST #creare" denies access do
      get :create, user: attribute_for(:user)
      expect(response).to redirect_to login_url
    end
  end
end
