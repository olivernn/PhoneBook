Given /^the following (.+) records?$/ do |record_name, table|
  factory = record_name.singularize.gsub(" ", "_")
  table.hashes.each do |hash|
    f = Factory(factory, hash)
  end
end

And /^(.+) has the following tweet records?$/ do |contact_first_name, table|
  contact = Contact.find_by_first_name(contact_first_name)
  table.hashes.each do |hash|
    f = Factory(:tweet, hash.merge(:contact => contact))
  end
end