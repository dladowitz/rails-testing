require 'spec_helper'

describe Phone do
  it "does not allow duplicate phone numbers per contact" do
    contact = create(:contact)

    create(:home_phone,
      contact: contact,
      phone: "408-666-9999")

    mobile_phone = build(:mobile_phone,
      contact: contact,
      phone: "408-666-9999")

    expect(mobile_phone).to have(1).errors_on(:phone)
  end

  it "allows two contacts to share a phone number" do
    contact1 = create(:contact)
    phone1   = create(:home_phone, contact: contact1, phone: "408-666-9999")

    contact2 = build(:contact)
    phone2   = build(:home_phone, contact: contact2, phone: "408-666-9999")

    expect(phone2).to be_valid
  end
end
