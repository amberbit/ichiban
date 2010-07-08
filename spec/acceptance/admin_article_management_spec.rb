require File.dirname(__FILE__) + '/acceptance_helper'

feature "Admin article management", %q{
    In order to have interesting content on my site
    As a user
    I want to have place to manage articles
  } do

  scenario "Creating new article"

  scenario "Publishing article by administrator"

  scenario "Not being able to publish article as not administrator"

  scenario "Not being able to edit/remove article as not administrator when it's already published"

  scenario "Seeing article preview"

  scenario "Editing existing article"
  
  scenario "Removing existing article"
end
