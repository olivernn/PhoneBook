Given /^I have no contacts$/ do
  Contact.delete_all
end

Then /^I should have ([0-9]+) contact$/ do |count|
  Contact.count.should == count.to_i
end