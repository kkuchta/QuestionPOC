class CreatePossibleValues < ActiveRecord::Migration
  def change
    create_table :possible_values do |t|
      t.text :value
      t.string :format
      t.string :next_question_slug
      t.references :question

      t.timestamps
    end
  end
end
