require 'machinist/active_record'

Group.blueprint do
  name { Faker::Lorem.word }
  semester { Random.rand(10) }
end

Mark.blueprint do
 mark { Random.rand(2..5) }
 subject
 student { Student.all.sample }
end

Student.blueprint do
  name    { Faker::Name.first_name }
  surname { Faker::Name.last_name  }
  email   { Faker::Internet.email  }
  registration_ip { Faker::Internet.ip_v4_address }
  supervisor_review { Faker::Lorem.sentences(1).join }
  date_of_birth { Time.at(rand * Time.now.to_i) }
  group
end