require 'declarative_authorization/maintenance'

class AddDemoDepartments < ActiveRecord::Migration
  include Authorization::Maintenance

  def self.up
    Authorization::Maintenance::without_access_control do
      d1 = Department.create :name => "RD", :description => "Research & Design", :subdomain => "rd", :layout_name => "departments"
      d2 = Department.create :name => "MS", :description => "Market & Sales", :subdomain => "ms", :layout_name => "departments"
      d3 = Department.create :name => "AA", :description => "Account & Audit", :subdomain => "aa", :layout_name => "departments"
      puts "Departments '#{d1.name}', '#{d2.name}', '#{d3.name}' created."

      Article.reset_column_information
      Article.find(1).update_attributes :department => d1
      Article.find(2).update_attributes :department => d2
      Article.find(3).update_attributes :department => d1
    end
  end

  def self.down
    Authorization::Maintenance::without_access_control do
      Department.delete_all
      puts "All department deleted."
    end
  end
end
