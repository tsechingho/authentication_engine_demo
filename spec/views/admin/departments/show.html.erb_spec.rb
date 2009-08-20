require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin_departments/show.html.erb" do
  include Admin::DepartmentsHelper
  before(:each) do
    assigns[:department] = @department = stub_model(Department,
      :name => "value for name",
      :description => "value for description",
      :subdomain => "value for subdomain",
      :layout_name => "value for layout_name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/value\ for\ subdomain/)
    response.should have_text(/value\ for\ layout_name/)
  end
end
