namespace :db do
  desc "Populate database with sample data."

  def random_times from, to
    Range.new(from, to).to_a.sample.times yield
  end

  task :populate => :environment do
    require 'machinist'
    require Rails.root.join 'spec', 'blueprints.rb'
    
    ['Math', 'Biology', 'CS', 'History', 'Literature'].each do |subj|
    	Subject.create name: subj
    end

    5.times   { Group.make! }
    7.times   { Student.make! group: Group.all.sample }
    14.times  { Mark.make! student: Student.all.sample, subject: Subject.all.sample }
    
    # For Student.registered_in_special_way query demo
    Student.last.update_attributes registration_ip: Student.first.registration_ip
    Student.all[1].update_attributes registration_ip: Student.first.registration_ip

    puts 'Population is done'
  end

  task :clear => :environment do
    [Student, Mark, Group, Subject].each &:delete_all
    puts 'Clear is done'
  end
  
  task :repopulate => [:clear, :populate]

end