require 'declarative_authorization/maintenance'

class Article < ActiveRecord::Base
  belongs_to :author, :class_name => "User"

  include Authorization::Maintenance
  using_access_control

  state_machine :initial => :created do
    event :confirm do
      transition :created => :confirmed
    end
    event :approve do
      transition :confirmed => :approved
    end
  end

  # user only need to have :approve privilege to update article (no :update privilege required)
  def approve
    Authorization::Maintenance::without_access_control do
      super
    end
  end
end
