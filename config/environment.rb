# Load the rails application
require File.expand_path('../application', __FILE__)

# 置き換える
$setting = Hashie::Mash.new(YAML.load_file(File.expand_path('../setting.yml', __FILE__)))


# Initialize the rails application
ZakkuriZaim::Application.initialize!
