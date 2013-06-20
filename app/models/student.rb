class Student < ActiveRecord::Base
  attr_accessible :date_of_birth, :email, :name, :registration_ip, :supervisor_review, :surname, :group_id
    
  validates_presence_of :email, :name, :registration_ip, :surname, :group

  
  has_many :marks
  has_many :subjects, through: :marks 

  belongs_to :group

  before_save :generate_supervisor_review

  scope :within_score, lambda { |min, max| includes(:marks).group(:student_id).having("AVG(marks.mark) <= ? AND AVG(marks.mark) >= ?", max, min) }
  
  scope :by_group, lambda { |group_name| includes(:group).where('groups.name = ?', group_name) }

  scope :by_semester, lambda { |semester| includes(:group).where('groups.semester = ?', semester) }

  def self.top_ten
    students = find(:all, include: :marks, :group => 'marks.student_id', order: "AVG(marks.mark) DESC", limit: 10)
    # If we have less than 10 students with marks, consider adding students with no marks
    if (count = students.count) < 10
      students + self.all( joins: "LEFT OUTER JOIN marks ON marks.student_id = students.id",
                          conditions: "marks.id IS NULL",
                          limit: 10 - count )
    end 
  end

  def average_mark
    marks.average(:mark).to_f
  end
  
  # Classmates with average score from .. to .. and name %name%
  def specific_classmates(name, min_score, max_score)
    self.class.where(group_id: self.group_id, name: name).within_score(min_score, max_score)
  end
  
  # Students registered by the same IPs and at least one of them has supervisor review
  def self.registered_in_special_way
    with_same_ip = where(registration_ip: select(:registration_ip).group(:registration_ip).having('COUNT(*) > 1')).
    where('supervisor_review IS NOT NULL')
  end

  def as_json(opts = {})
    json = super except: :lock_version, include: { marks: { include: :subject }  }
    json[:average_mark] = self.average_mark
    json[:semester] = self.group.semester
    json
  end

  private
    
    # Where should it really come from?
    # seed randomly
    def generate_supervisor_review
      self.supervisor_review = Faker::Lorem.sentences(Random.rand(1..7)).join if Random.rand(10).odd?
    end

end
