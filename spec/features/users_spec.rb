require "spec_helper"

feature "User Management" do
  scenario "adds a new user", js: true do
    admin = create(:admin)
    sign_in admin

    expect{
      click_link "Users"
      click_link "New User"

      fill_in "Email", with: "teresa.huang@gmail.com"
      fill_in "Password", with: "123456"
      fill_in "Password confirmation", with: "123456"
      click_button "Create User"
    }.to change(User, :count).by(1)


    expect(current_path).to eq users_path
    expect(page).to have_content "New user created"

    within "h1" do
      expect(page).to have_content "Users"
    end

    expect(page).to have_content "teresa.huang@gmail.com"
  end
end
