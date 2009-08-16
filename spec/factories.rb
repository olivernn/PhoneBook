Factory.define :contact do |f|
  f.first_name "Oliver"
  f.last_name "Nightingale"
  f.email "oliver@mail.com"
  f.phone "00 123 123456"
end

Factory.define :tweet do |f|
  f.text "tweeting is fun"
  f.guid "12345678"
  f.tweeted_at Time.now
  f.association :contact
end