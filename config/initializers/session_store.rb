# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_phonebook_session',
  :secret      => '534486109d5a29bebe9082906bb0c37421e5546a44f25ef4cad4e4a68a8747866b2d0060903d59ecd890a31090fb4822cead983976ee4ac1a26cc6ea505226dc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
