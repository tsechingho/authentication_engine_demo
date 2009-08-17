# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_authentication_engine_demo_session',
  :secret      => '5a1e84755632ce40d0421c59540f7250ec579c56fe12c4151a3bb1789c7611a9c46609b49efd8a61f2d409fc15bac2ddc2e27b24b1a05555395e9cd92a056a59'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
