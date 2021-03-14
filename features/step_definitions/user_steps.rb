When /^I fill in the "email" field with "([^"]*)"$/ do |value|
    fill_in('email', :with => value)
end

When /^I fill in the "password" field with "([^"]*)"$/ do |value|
    fill_in('password', :with => value)
end