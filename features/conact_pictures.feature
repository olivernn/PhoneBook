Feature: Contact Pictures
  In order put a name to a face
  As a phonebook user
  I want to be able to upload an image for a contact

  @slow
	Scenario: Adding a picture to an existing contact
	  Given the following contact record
	 | first_name | last_name | email                                | phone         |
	 | Paul       | Kossof    | paul-kossof@great-gig-in-the-sky.com | 00 123 456789 |
    When I am on Paul's contact page
		And I follow "Edit"
		And I attach the image "giraffe.jpg" to picture file field
		And I press "Update"
	  Then I should see the picture
		
		
		


  
