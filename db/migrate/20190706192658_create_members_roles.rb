class CreateMembersRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :members_roles do |t|
      t.references :member, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
