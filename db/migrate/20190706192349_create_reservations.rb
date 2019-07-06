class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :space, null: false, foreign_key: true
      t.datetime :start_at
      t.datetime :end_at
      t.text :note

      t.timestamps
    end
  end
end
