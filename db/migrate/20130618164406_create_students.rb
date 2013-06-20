class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :surname
      t.integer :group_id
      t.date :date_of_birth
      t.string :email
      t.string :registration_ip
      t.datetime :registration_time
      t.text :supervisor_review

      t.timestamps
    end
  end
end
