class AddDepartmentIdToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :department_id, :integer
  end

  def self.down
    remove_column :articles, :department_id
  end
end
