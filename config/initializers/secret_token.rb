# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
W1bbs::Application.config.secret_token = ENV['SECRET_TOKEN'] || '51cc6c52dfa3e6137fcf633cdb094afb2c08ef939f56806d3ea4f8ae811be667922dc1939b8b956d4dc81450573738e1f9bb914f35268f8cc445846dcfaa7a3d'
