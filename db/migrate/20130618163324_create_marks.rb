class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.integer :student_id
      t.integer :subject_id
      t.integer :mark

      t.timestamps
    end
  end
end
