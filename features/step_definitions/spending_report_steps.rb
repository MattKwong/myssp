include Devise::TestHelpers

When /^I click on the spending report item on the Reports Menu$/ do

  click_link "Sierra Service Project Manager"
  click_link 'Reports'
  click_link 'Spending Report'
end

Then /^I see the Spending Report page with title 'Spending Summary Report'$/ do
  save_and_open_page
  page.body.should have_selector("form #startDate[@value='2013-06-01']")
end

#These two conditions pass but I these should fail...
And /^start date equal to program start date$/ do
  page.body.should have_content('Spending Summary Report')
end

And /^end date equal to program end date$/ do
  end_date = Report.new.all_programs.first.end_date.to_date
  puts end_date
  page.body.should have_selector("form #endDate[@value='#{end_date.to_s}']")
end

Given /^I see the Spending Report page$/ do
  if @current_admin_user
    visit root_path
    click_button "Sign Out"
  end
  @current_admin_user = FactoryGirl.create("admin_user")
  #@current_admin_user.confirm!
  @email = @current_admin_user.email
  @password = @current_admin_user.password
  visit root_path
  click_link 'Please sign in.'
  fill_in "Email", :with => @email
  fill_in "Password", :with => @password
  check 'Remember me'
  click_button 'Sign in'
  click_link "Sierra Service Project Manager"
  #click_link 'Reports'
  #click_link 'Spending Report'

end

When /^I click on the Show Report button$/ do
  click_link 'Reports'
  click_link 'Spending Report'
  save_and_open_page
end

Then /^I see the Spending Report table on the page$/ do
  save_and_open_page
  pending # express the regexp above with the code you wish you had
end
