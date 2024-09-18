class CreateSurveys < ActiveRecord::Migration[7.1]
  def change
    create_table :surveys do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.boolean :closed
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
