class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.text :permissions, null: false
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
