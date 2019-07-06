class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.text :permissions
      t.integer :position

      t.timestamps
    end
  end
end
