class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :semester

      t.timestamps
    end
  end
end
