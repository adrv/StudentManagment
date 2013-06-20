class Mark < ActiveRecord::Base
  attr_accessible :mark

  validates_presence_of :subject, :student, :mark

  belongs_to :subject
  belongs_to :student

end
