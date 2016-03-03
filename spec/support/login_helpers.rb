module LoginHelpers

  def log_in(user)
    request.session[:user_id] = user.id
  end

  def log_in_via_web(user)
    visit new_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

end
