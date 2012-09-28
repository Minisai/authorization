class Role < ActiveRecord::Base
  attr_accessible :name

  has_many :users

  def self.admin
    find_by_name("Admin")
  end

  def self.user
    find_by_name("User")
  end

end
