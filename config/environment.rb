# Load the rails application
require File.expand_path('../application', __FILE__)

# OmniAuth認証連携したので不要
# # bundlerのhashieを読み込んだ後. 開発用token
# $secret = Hashie::Mash.new(YAML.load_file(File.expand_path('../secret.yml', __FILE__)))


# Initialize the rails application
ZakkuriZaim::Application.initialize!
