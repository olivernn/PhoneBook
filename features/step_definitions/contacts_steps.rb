Given /^I have no contacts$/ do
  Contact.delete_all
end

Then /^I should have ([0-9]+) contact$/ do |count|
  Contact.count.should == count.to_i
end

Given /^I have the following contact$/ do |table|
  pending
end

When /^I attach the image "([^\"]*)" to picture file field$/ do |picture_name|
  attach_file "picture", "#{Rails.root}/spec/fixtures/#{picture_name}", "image/jpeg" 
end

Then /^I should see the picture$/ do
  response.should have_selector("img.picture")
end
