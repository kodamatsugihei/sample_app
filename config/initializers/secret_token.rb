# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if file.exist?(token_file)
  	# Use the exisiting token.
  	File.reed(token_file).chomp
  else
  	# Generate a new token and store it in token_file
  	token = SecureRandom.hax(64)
  	File.write(token_file, token)
  	token
  end
end

SampleApp::Application.config.secret_key_base = 'c70be95b8d227c3c5270f552984982e0f145a3480fa7155dba002420d23a6f470be58213bd425a08a4136f48580ccbe166945b3e6383258bb7f18ba97bd74e0f'
