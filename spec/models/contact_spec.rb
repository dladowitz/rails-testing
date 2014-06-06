require 'spec_helper'

describe Contact do
  it "is valid with a firstname, lastname and email" do
    contact = Contact.new(
      firstname: "Charles",
      lastname:  "Xavier",
      email:     "prof@xmen.com"
    )
    expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    expect(Contact.new(firstname: nil)).to have(1).error_on(:firstname)
  end

  it "is invalid without a lastname" do
    expect(Contact.new(lastname: nil)).to have(1).error_on(:lastname)
  end

  it "is invalid without an email address" do
    expect(Contact.new(email: nil)).to have(1).error_on(:email)
  end

  it "is invalid with a duplicate email address" do
    Contact.create(
      firstname: "Charles",
      lastname:  "Xavier",
      email:     "prof@xmen.com"
    )
    contact = Contact.create(
      firstname: "Scott",
      lastname:  "Summers",
      email:     "prof@xmen.com"
    )
    expect(contact).to have(1).error_on(:email)
  end

  it "returns a contact's full name as a string" do
    contact = Contact.new(firstname: "Charles", lastname: "Xavier", email: "prof@xmen.com")

    expect(contact.name).to eq("Charles Xavier")
  end

  describe "filter lastname by letter" do
    before :each do
      @scott = Contact.create(firstname: "Scott", lastname: "Summers", email: "scott@xmen.com")
      @jean  = Contact.create(firstname: "Jean",  lastname: "Gray",    email: "jean@xmen.com")
      @kevin = Contact.create(firstname: "Kevin", lastname: "Sydney", email: "kevin@xmen.com")
    end

    context "matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("S")).to eq [@scott, @kevin]
      end
    end

    context "non-matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("S")).to_not eq [@jean]
      end
    end

  end
end
