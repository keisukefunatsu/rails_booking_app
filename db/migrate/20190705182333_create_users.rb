class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :admin, default: false
      t.string :activation_token
      t.string :password_reset_token
      t.boolean :activated, default: false
      
      t.timestamps
    end
    add_index :users, :activation_token, unique: true
    add_index :users, :password_reset_token, unique: true
  end
end
