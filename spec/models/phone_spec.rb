require 'spec_helper'

describe Phone do
  it "does not allow duplicate phone numbers per contact" do
    contact = Contact.create(firstname: "Charles", lastname: "Xavier", email: "prof@xmen.com")

    contact.phones.create(phone_type: "home", phone: "408-666-1212")
    mobile_phone = contact.phones.build(phone_type: "mobile", phone: "408-666-1212" )

    expect(mobile_phone).to have(1).errors_on(:phone)
  end

  it "allows two contacts to share a phone number" do
    contact1 = Contact.create(firstname: "Charles", lastname: "Xavier", email: "prof@xmen.com")
    contact1.phones.create(phone_type: "home", phone: "408-666-1212")

    contact2 = Contact.create(firstname: "Scott", lastname: "Summers",email: "scott@xmen.com")
    phone = contact2.phones.build(phone_type: "home", phone: "408-666-1212")

    expect(phone).to be_valid
  end
end
