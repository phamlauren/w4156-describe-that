Given /the following users exist/ do |users_table|
    users_table.hashes.each do |user|
      User.create user
    end
  end

When /^I fill in the "email" field with "([^"]*)"$/ do |value|
    fill_in('user_email', :with => value)
end

When /^I fill in the "password" field with "([^"]*)"$/ do |value|
    fill_in('user_password', :with => value)
end