module HelperMethods
  # Put here any helper method you need to be available in all your acceptance tests

  def when_i_sign_in_as(email = "john@doe.com")
    when_user_exists(email)
    visit "/users/sign_out"
    visit "/admin"
    fill_in "Email", with: "john@doe.com"
    fill_in "Password", with: "testtest"
    click_button "Sign in"
  end

  def when_user_exists(email="john@doe.com", is_admin = false)
    u = User.find(:first, conditions: {email: email})
    u = User.create( email: email, name: "John Doe", password: "testtest",
                     picture: File.new("#{Rails.root}/spec/fixtures/picture.jpg") )
    if is_admin
      u.admin = true
      u.save
    end
    u
  end
  
end

Rspec.configuration.include(HelperMethods)
