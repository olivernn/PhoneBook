Given /^the following (.+) records?$/ do |record_name, table|
  factory = record_name.singularize.gsub(" ", "_")
  table.hashes.each do |hash|
    f = Factory(factory, hash)
  end
end