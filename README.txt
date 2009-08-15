Assumptions:

1) A contact is not valid without a first and last name.
2) A contact is valid without an email address.
3) A contact picture can be no larger than 1MB.
4) A contact is valid without a picture.
5) A contact picture can only be a jpg.
6) A contact can have only one picture.
7) When searching for contacts there will be one search query, since you want to search by first name OR last name.  So you can search for "Oliver" or "Nightingale" or both at the same time.
8) Search parameters should be pre-fixed with a wildcard - this will mean MySQL does not use an index.

AJAX autocomplete

I chose to use the list of contacts as the result for the autocomplete of the search, as outlined in the requirements.  The reason for this was that it satisfied the requirement of the matching results being displayed and clicking on the name would then still go to the show action for the clicked name.