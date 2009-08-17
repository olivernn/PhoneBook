Assumptions:

1) A contact is not valid without a first and last name.
2) A contact is valid without an email address.
3) A contact picture can be no larger than 1MB.
4) A contact is valid without a picture.
5) A contact picture can only be a jpg.
6) A contact can have only one picture.
7) You can search on either first name, last name or both combined, this is done with separate fields for first and last name.
8) Search parameters shouldn't be pre-fixed with a wildcard - this will mean MySQL can use an index, however I have not included an index in the database for this app.

AJAX autocomplete

I chose to use the list of contacts as the result for the autocomplete of the search, as outlined in the requirements.  The reason for this was that it satisfied the requirement of the matching results being displayed and clicking on the name would then still go to the show action for the clicked name.

Search

I was very tempted to use something link thinking_sphinx for the search, I really wanted to have a go at using it as I haven't had a chance to yet in the projects I have worked on before, in the end though I think it would have probably been overkill, so instead you can search on either first name or last name using plain old sql.

Styles

I have included a basic stylesheet for the app, I probably spent a little too long tweaking this but again this is the kind of the thing that I like to play around with!

Javascripts

I kept javascript to the bare minimum, as described in the brief I only used AJAX for the autocomplete.  I did try and get fancy, using javascript for inline forms for the search form, these could do with a little tweaking to work correctly with the AJAX, and are perhaps a bit too much for a simple exercise, but I had recently seen some examples of it and wanted to try it out for myself.

Twitter

I chose to use twitter_search as the library for interacting with the twitter search api, I think it works fairly well and it was fun getting to experiment with something new in a rails app.  I have inlcuded a rake task to load the recent tweets, rake tweets:refresh should do the trick.

Tests

Although the exercise did not require a test suite I decided to use both cucumber and rspec to help me build the app, this was more for my own aid than to try and produce a complete test suite, there are certainly parts that are not well covered with tests.