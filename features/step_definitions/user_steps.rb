When /^I fill in the "email" field with "([^"]*)"$/ do |value|
    fill_in('user_email', :with => value)
end

When /^I fill in the "password" field with "([^"]*)"$/ do |value|
    fill_in('user_password', :with => value)
end