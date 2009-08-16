Feature: Viewing recent tweets
  In order to see what a contact has been tweeting
  As a PhoneBook User
  I want to be able view a contacts latest 5 tweets
	
	Scenario: Adding a contacts twitter user name
	  Given the following contact record
		 | first_name | last_name   | email                   | phone         |
		 | Oliver     | Nightingale | oliver@minimalpixel.net | 00 123 456789 |
	  When I am on Oliver's contact page
		And I follow "Edit"
		And I fill in "Twitter User Name" with "minimalpixel"
		And I press "Update"
	  Then I should see "Successfully updated contact."
		And I should see "minimalpixel"
		
	Scenario: Viewing a contacts recent tweets
	  Given the following contact record
		 | first_name | last_name   | email                   | phone         | twitter_user_name |
		 | Oliver     | Nightingale | oliver@minimalpixel.net | 00 123 456789 | minimalpixel      |
		And Oliver has the following tweet records
		 | text                                                                                    |
		 | building a phone book app for new bamboo application!                                   |
		 | Man City, finnish in the top 4 this season?                                             |
		 | MOTD is back!                                                                           |
		 | getting tickets for wales v new zealand, sweet!                                         |
		 | #welovetheNHS because It saves lives and doesn't require a credit card before doing so. |
		 | RT @rbates Something fun to do on a Saturday afternoon: http://bit.ly/ArykQ             |
	  When I am on Oliver's contact page
	  Then I should see "building a phone book app for new bamboo application!"
		And I should see "Man City, finnish in the top 4 this season?"
		And I should see "MOTD is back!"
		And I should see "getting tickets for wales v new zealand, sweet!"
		And I should see "#welovetheNHS because It saves lives and doesn't require a credit card before doing so."
		And I should not see "RT @rbates Something fun to do on a Saturday afternoon: http://bit.ly/ArykQ"
	
	
	
	

  
