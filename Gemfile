source 'https://rubygems.org'

# Use the gems from the inner Gemfile inside PRODUCTNAME
gemfile_path = File.join(File.dirname(__FILE__), 'PRODUCTNAME', 'Gemfile')
eval_gemfile(gemfile_path) if File.exist?(gemfile_path)
