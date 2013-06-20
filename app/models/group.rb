class Group < ActiveRecord::Base
  attr_accessible :semester, :name

  has_many :students
  
end
