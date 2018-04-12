source 'https://rubygems.org'

gem 'danger', '~> 5.5.11'
gem 'danger-swiftlint', '~> 0.16.0'
gem 'danger-xcov', '~> 0.4.1'
# gem 'xcov', '~> 1.4.0'
gem 'xcov', :git => 'https://github.com/Raizlabs/xcov.git', :branch => '1.4.0-rz'


gem 'fastlane', '~> 2.89.0'
gem 'cocoapods', '~> 1.5.0'
gem 'synx', '~> 0.2.1'
gem 'nanaimo', '~> 0.2.2'

plugins_path = File.join(File.dirname(__FILE__), 'app', 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)