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
      t.boolean :adult, default: false
      t.boolean :accept_r, default: false
      t.boolean :accept_m, default: false
      t.integer :day1, default: nil
      t.integer :day2, default: nil
      t.integer :day3, default: nil
      t.integer :day4, default: nil
      t.integer :day5, default: nil
      t.integer :finale, default: nil
      t.integer :score, default: 0

      t.timestamps null: false
    end
  end
end
