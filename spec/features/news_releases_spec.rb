require "spec_helper"

feature "News Releases" do
  context "As a user" do
    scenario "adds a news release" do
      user = create(:user)
      sign_in user

      expect{
        click_link "News Releases"
        click_link "Add a News Release"
        


      }.to change(NewsRelease, :count).by(1)

    end

  end

  context "As a guest" do
    scenario "reads a news release"
  end
end
