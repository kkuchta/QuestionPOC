class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :format
      t.text :prompt
      t.text :instructions
      t.text :focus
      t.string :slug
      t.text :options_json
      t.references :question_set

      t.timestamps
    end
  end
end
