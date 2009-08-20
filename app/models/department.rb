class Department < ActiveRecord::Base
  has_many :articles, :dependent => :nullify

  using_access_control
end
