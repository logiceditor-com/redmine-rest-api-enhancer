require 'redmine'
require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    require_dependency File.expand_path(File.join(File.dirname(__FILE__), 'app/controllers/rest_api_enhancer_controller'))
  end
else
  Dispatcher.to_prepare :redmine_rest_api_enhancer do
  end
end

Redmine::Plugin.register :redmine_rest_api_enhancer do
  name 'Redmine REST API Enhancer plugin'
  author 'Alexey Romanov'
  description 'Add some features to REST API'
  version '0.0.1'
  url 'http://logiceditor.com'
  author_url 'http://logiceditor.com'

  permission :rest_api_enhancer, { :rest_api_enhancer => [:watchers] }
  permission :rest_api_enhancer, { :rest_api_enhancer => [:users] }
end
