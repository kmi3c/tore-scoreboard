class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :user_id
      t.integer :score, default: 0

      t.timestamps null: false
    end
  end
end
