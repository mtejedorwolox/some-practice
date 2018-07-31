class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :user, foreign_key: true
      t.text :text, null: false
      t.boolean :is_private, default: false

      t.timestamps
    end
  end
end
