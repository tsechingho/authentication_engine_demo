require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin_departments/index.html.erb" do
  include Admin::DepartmentsHelper

  before(:each) do
    assigns[:admin_departments] = [
      stub_model(Department,
        :name => "value for name",
        :description => "value for description",
        :subdomain => "value for subdomain",
        :layout_name => "value for layout_name"
      ),
      stub_model(Department,
        :name => "value for name",
        :description => "value for description",
        :subdomain => "value for subdomain",
        :layout_name => "value for layout_name"
      )
    ]
  end

  it "renders a list of admin_departments" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
    response.should have_tag("tr>td", "value for subdomain".to_s, 2)
    response.should have_tag("tr>td", "value for layout_name".to_s, 2)
  end
end
