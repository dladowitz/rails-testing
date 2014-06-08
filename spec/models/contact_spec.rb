require 'spec_helper'

describe Contact do
  it "has a valid factory" do
    expect(build(:contact)).to be_valid
  end

  it "is valid with a firstname, lastname and email" do
    contact = create(:contact)
    expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    contact = build(:contact, firstname: nil)
    expect(contact).to have(1).error_on(:firstname)
  end

  it "is invalid without a lastname" do
    contact = build(:contact, lastname: nil)
    expect(contact).to have(1).error_on(:lastname)
  end

  it "is invalid without an email address" do
    contact = build(:contact, email: nil)
    expect(contact).to have(1).error_on(:email)
  end

  it "is invalid with a duplicate email address" do
    create(:contact, email: "hankmcoy@xmen.com")
    contact = build(:contact, email: "hankmcoy@xmen.com")

    expect(contact).to have(1).error_on(:email)
  end

  it "returns a contact's full name as a string" do
    contact = build(:contact, firstname: "Charles", lastname: "Xavier")

    expect(contact.name).to eq "Charles Xavier"
  end

  it "has three phone numbers when created" do
    contact = create(:contact)
    expect(contact.phones.count).to eq 3
  end

  describe "filter lastname by letter" do
    before :each do
      @scott  = create(:contact, firstname: "Scott",  lastname: "Summers")
      @jean   = create(:contact, firstname: "Jean",   lastname: "Grey")
      @kevin  = create(:contact, firstname: "Kevin",  lastname: "Sydney")
      @rachel = create(:contact, firstname: "Rachel", lastname: "Summers")
      
    end

    context "matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("S")).to eq [@scott, @rachel, @kevin]
      end
    end

    context "non-matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("S")).to_not eq [@jean]
      end
    end

    context "when a letter isn't given" do
      it "returns all Contacts ordered by lastname first then by firstname" do
        expect(Contact.by_letter).to eq [@jean, @rachel, @scott, @kevin]
      end
    end
  end
end
