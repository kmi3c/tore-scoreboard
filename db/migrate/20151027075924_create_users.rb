class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :first_name
      t.string  :last_name
      t.string  :p_first_name
      t.string  :p_last_name
      t.string  :nickname
      t.string  :phone
      t.text    :signature_json
      t.string  :signature_uid
      t.string  :signature_name
      t.boolean :adult
      t.boolean :accept_r
      t.boolean :accept_m
      t.integer :day1, default: 0
      t.integer :day2, default: 0
      t.integer :day3, default: 0
      t.integer :day4, default: 0
      t.integer :day5, default: 0
      t.integer :finale, default: 0
      t.integer :score, default: 0

      t.timestamps null: false
    end
  end
end
