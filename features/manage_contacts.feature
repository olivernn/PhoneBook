Feature: Manage contact information
  In order to keep track of the people I work with
  As a wannabe New Bamboo developer
  I want to be able to create, edit and view their contact information

  Scenario: Create contact
    Given I have no contacts
		And I am on the contact list page
    When I follow "New Contact"
		And I fill in "First Name" with "Jimi"
		And I fill in "Last Name" with "Hendrix"
		And I fill in "Email" with "jimi_hendrix@great_gig_in_the_sky.com"
		And I fill in "Phone" with "02012341234"
		And I press "Create"
    Then I should see "Successfully created contact."
		And I should see "Jimi Hendrix"
		And I should have 1 contact
  
  
  Scenario: Edit contact
    Given I have the following contact
	 | first name | last name | email                                | phone       |
	 | Paul       | Kossof    | paul_kossof@great_gig_in_the_sky.com | 02012341234 |
    When I am on the Paul Kossof contact page
		And I follow "Edit"
		And I fill in "Email" with "paul_kossof@all_right_now.com"
		And I press "Update"
		Then I should see "Successfully updated contact."
    And I should see "paul_kossof@all_right_now.com"

	Scenario: List contacts
	  Given I have the following contact # need enough so that we can see pagination
	 | first name | last name | email                                  | phone       |
	 | Duanne     | Allman    | duanne_allman@great_gig_in_the_sky.com | 02012341234 |
	 | Stevie Ray | Vaughn    | srv@great_gig_in_the_sky.com           | 02043211234 |
	 | Marc       | Bolan     | marc@t-rex.com                         | 02044448888 |
	 | Jeff       | Buckley   | jeff@hallelujah.com                    | 02012345678 |
	 | Kurt       | Cobain    | kurt@nevermind.com                     | 02055515552 |
	 | Ian        | Curtis    | ian@joy_division.com                   | 02012349876 |
	 | Danny      | Gatton    | dg@great_gig_in_the_sky.com            | 02012341234 |
	 | Michael    | Hutchence | michael@great_gig_in_the_sky.com       | 02012341235 |
	 | Phil       | Lynott    | phil@great_gig_in_the_sky.com          | 02043214321 |
	 | John       | Lennon    | john@strawberry_fields.com             | 02055559999 |
	 | Robert     | Johnson   | rob@the_crossroads.com                 | 02012345678 |
	  When I am on the contact list page
	  Then I should see "Duanne"
		And I should see "Stevie Ray"
		And I should see "Marc"
		And I should see "Jeff"
		And I should see "Kurt"
		And I should see "Ian"
		And I should see "Gatton"
		And I should see "michael@great_gig_in_the_sky.com"
		And I should see "Lynott"
		And I should see "Lennon"
		And I should not see "rob@the_crossroads.com"
		And I should see "Next"
  
	Scenario: View contact
	  Given I have the following contact
	 | first name | last name | email                             | phone       |
	 | Eddie      | Cochran   | eddie_cochran@dead_rock_stars.com | 02012341234 |
	  When I am on the Eddie Cochran contact page
	  Then I should see "Eddie"
		And I should see "Cochran"
		And I should see "eddie_cochran@dead_rock_stars.com"
		And I should see "02012341234"
	
	
	