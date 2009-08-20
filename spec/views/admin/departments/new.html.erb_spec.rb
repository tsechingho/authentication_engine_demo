require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin_departments/new.html.erb" do
  include Admin::DepartmentsHelper

  before(:each) do
    assigns[:department] = stub_model(Department,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description",
      :subdomain => "value for subdomain",
      :layout_name => "value for layout_name"
    )
  end

  it "renders new department form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_departments_path) do
      with_tag("input#department_name[name=?]", "department[name]")
      with_tag("input#department_description[name=?]", "department[description]")
      with_tag("input#department_subdomain[name=?]", "department[subdomain]")
      with_tag("input#department_layout_name[name=?]", "department[layout_name]")
    end
  end
end
