# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

if Rails::VERSION::MAJOR >= 3
  RedmineApp::Application.routes.draw do
    match 'rest_api_enhancer/issues/:id/watchers', :to => 'rest_api_enhancer#watchers', :via => :get
  end
else
  ActionController::Routing::Routes.draw do |map|
    map.connect 'rest_api_enhancer/issues/:id/watchers.:format', :controller => 'rest_api_enhancer', :action => 'watchers', :conditions => {:method => :get}
  end
end