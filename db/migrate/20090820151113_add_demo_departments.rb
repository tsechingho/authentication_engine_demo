require 'declarative_authorization/maintenance'

class AddDemoDepartments < ActiveRecord::Migration
  include Authorization::Maintenance

  def self.up
    Authorization::Maintenance::without_access_control do
      d1 = Department.create :name => "RD", :description => "Research & Design", :subdomain => "rd", :layout_name => "department"
      d2 = Department.create :name => "MS", :description => "Market & Sales", :subdomain => "ms", :layout_name => "department"
      d3 = Department.create :name => "AA", :description => "Account & Audit", :subdomain => "aa", :layout_name => "department"
      puts "Departments '#{d1.name}', '#{d2.name}', '#{d3.name}' created."
      
      Article.find(1).update_attribute :department_id, d1.id
      Article.find(2).update_attribute :department_id, d2.id
      Article.find(3).update_attribute :department_id, d1.id
    end
  end

  def self.down
    Authorization::Maintenance::without_access_control do
      Department.delete_all
      puts "All department deleted."
    end
  end
end
