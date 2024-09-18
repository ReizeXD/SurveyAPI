class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.integer :question_type, default: 0
      t.references :survey, null: false, foreign_key: true

      t.timestamps
    end
  end
end
