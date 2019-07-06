class CreateSpaces < ActiveRecord::Migration[6.0]
  def change
    create_table :spaces do |t|
      t.references :group, null: false, foreign_key: true
      t.datetime :start_at
      t.datetime :end_at
      t.text :note

      t.timestamps
    end
  end
end
