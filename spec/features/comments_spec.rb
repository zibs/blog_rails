require 'rails_helper'

RSpec.feature "Comments", type: :feature do

  let!(:user){create(:user)}
  let!(:post){create(:post)}

  context "authenticated user" do
    before {log_in_via_web(user)}
    it "displays the comment on the page, displays a flash message " do

      visit post_path(post)
      valid_comment_attrs = attributes_for(:comment)
      fill_in "comment_body", with: valid_comment_attrs[:body]
      click_button "Create Comment"
  
      expect(page).to have_text /#{valid_comment_attrs[:body]}/i
      expect(page).to have_text /Comment Created/i

    end
  end
end
