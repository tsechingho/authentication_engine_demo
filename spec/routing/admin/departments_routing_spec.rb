require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::DepartmentsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "admin_departments", :action => "index").should == "/admin/departments"
    end

    it "maps #new" do
      route_for(:controller => "admin_departments", :action => "new").should == "/admin/departments/new"
    end

    it "maps #show" do
      route_for(:controller => "admin_departments", :action => "show", :id => "1").should == "/admin/departments/1"
    end

    it "maps #edit" do
      route_for(:controller => "admin_departments", :action => "edit", :id => "1").should == "/admin/departments/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "admin_departments", :action => "create").should == {:path => "/admin/departments", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "admin_departments", :action => "update", :id => "1").should == {:path =>"/admin/departments/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "admin_departments", :action => "destroy", :id => "1").should == {:path =>"/admin/departments/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/admin/departments").should == {:controller => "admin_departments", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/admin/departments/new").should == {:controller => "admin_departments", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/admin/departments").should == {:controller => "admin_departments", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/admin/departments/1").should == {:controller => "admin_departments", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/admin/departments/1/edit").should == {:controller => "admin_departments", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/admin/departments/1").should == {:controller => "admin_departments", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/admin/departments/1").should == {:controller => "admin_departments", :action => "destroy", :id => "1"}
    end
  end
end
