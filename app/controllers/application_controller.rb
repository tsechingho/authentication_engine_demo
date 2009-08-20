# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  unloadable # only need to set unloadable for engine classes or modules
  include AuthenticationEngine::Authentication::Base
  include AuthenticationEngine::Authorization::Base
  include AuthenticationEngine::Localization

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # You must add rules first then invoke :merge_authorization_rules by before_filter
  add_authorization_rules "#{RAILS_ROOT}/config/authorization_rules.rb"
  add_authorization_rules "#{RAILS_ROOT}/config/article_authorization_rules.rb"
  #add_authorization_rules %{
  #  authorization do
  #    role :test_role, :title => 'Test Role' do
  #      description "Test Role Description"
  #    end
  #  end
  #}
  before_filter :merge_authorization_rules

  protected

  # request.subdomains != current_subdomain
  def find_current_department
    redirect_to root_url unless current_subdomain
    @current_department = Department.find_by_subdomain(current_subdomain)
    self.class.layout(@current_department ? @current_department.layout_name : 'application')
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "No such department"
    redirect_to root_url
  end
end
