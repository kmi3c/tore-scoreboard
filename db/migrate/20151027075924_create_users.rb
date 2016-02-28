class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :first_name
      t.string  :last_name
      t.string  :p_first_name
      t.string  :p_last_name
      t.string  :nickname
      t.text    :signature_json
      t.string  :signature_uid
      t.string  :signature_name
      t.boolean :adult
      t.text    :days
      t.integer :score, default: 0

      t.timestamps null: false
    end
  end
end
