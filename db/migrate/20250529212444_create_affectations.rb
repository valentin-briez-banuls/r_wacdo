class CreateAffectations < ActiveRecord::Migration[8.0]
  def change
    create_table :affectations do |t|
      t.references :collaborateur, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true
      t.references :fonction, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
