require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  let!(:user){create(:user)}

  describe "index" do
    it "displays the text `Current Posts` on it" do
      visit root_path
      # expect(page).to have_text /current posts/i
      expect(page).to have_selector "h1", text: /Current Posts/i
    end
  end

  describe "create post" do

    context "with valid post params" do
      before { log_in_via_web(user) }
      it "renders the new post's page, and displays a flash message" do
        valid_post = attributes_for(:post)
        visit new_post_path

        # save_and_open_page
        fill_in "Title", with: valid_post[:title]
        fill_in "Body", with: valid_post[:body]
        click_button "Post Post"
        # binding.pry
        expect(current_path).to eq(post_path(Post.last))
        expect(page).to have_text  /posted/i
      end
    end
    context "with invalid params" do
      before { log_in_via_web(user) }
      it "renders an error, and displays a flash message" do

        visit new_post_path
        fill_in "Title", with: ""
        click_button "Post Post"

        expect(current_path).to eq(posts_path)
        expect(page).to have_text /failure/

      end
    end
    context "unathenticated" do
      it "redirects to the new session path" do
        visit new_post_path
        expect(current_path).to eq(new_session_path)
      end
    end
  end

# end rspec
end
