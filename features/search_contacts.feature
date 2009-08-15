Feature: Search contacts
  In order to find a specific contact
  As a phonebook user
  I want to be able to search contacts using first OR last name

  Background:
		Given the following contact records
		 | first_name | last_name | email                                  | phone         |
		 | Duanne     | Allman    | duanne-allman@great-gig-in-the-sky.com | 00 123 456789 |
		 | Stevie-Ray | Vaughn    | srv@great-gig-in-the-sky.com           | 00 123 456789 |
		 | Marc       | Bolan     | marc@t-rex.com                         | 00 123 456789 |
		 | Jeff       | Buckley   | jeff@hallelujah.com                    | 00 123 456789 |
		 | Kurt       | Cobain    | kurt@nevermind.com                     | 00 123 456789 |
		 | Ian        | Curtis    | ian@joy-division.com                   | 00 123 456789 |
		 | Danny      | Gatton    | dg@great-gig-in-the-sky.com            | 00 123 456789 |
		 | Michael    | Hutchence | michael@great-gig-in-the-sky.com       | 00 123 456789 |
		 | Phil       | Lynott    | phil@great-gig-in-the-sky.com          | 00 123 456789 |
		 | John       | Lennon    | john@strawberry-fields.com             | 00 123 456789 |
		 | Robert     | Johnson   | rob@the-crossroads.com                 | 00 123 456789 |
		 | Shannon    | Hoon      | shannon@blind-melon.com                | 00 123 456789 |
		 | Jim        | Morrison  | jim@the-doors.com                      | 00 123 456789 |
		 | Sterling   | Morrison  | sterling@velvet-underground.com        | 00 123 456789 |

	Scenario: Searching by full first name only
	  Given I am on the contact list page
	  When I fill in "first_name" with "Duanne"
		And I press "Search"
	  Then I should see "Duanne Allman"
		And I should not see "Marc Bolan"
		And I should not see "Next"
	
	Scenario: Searching by partial name only
	  Given I am on the contact list page
	  When I fill in "last_name" with "an"
		And I press "Search"
	  Then I should see "Duanne Allman"
		And I should see "Marc Bolan"
		And I should not see "Ian Curtis"
		And I should not see "Danny Gatton"
		And I should not see "Shannon Hoon"
		And I should not see "Stevie-Ray Vaughn"
		And I should not see "Jeff Buckley"
		And I should not see "Kurt Cobain"
		And I should not see "Michael Hutchence"
		And I should not see "Phil Lynott"
		And I should not see "John Lennon"
		And I should not see "Robert Johnson"
		And I should not see "Next"
	
	Scenario: searching by last name only
	  Given I am on the contact list page
	  When I fill in "last_name" with "Bolan"
		And I press "Search"
	  Then I should see "Marc Bolan"
		And I should not see "Danny Gatton"
		And I should not see "Next"
		
	Scenario: searching by full name
	  Given I am on the contact list page
	  When I fill in "first_name" with "Jim"
		And I fill in "last_name" with "Morrison"
		And I press "Search"
	  Then I should see "Jim Morrison"
		And I should not see "Sterling Morrison"
		And I should not see "Next"
	
	
	
