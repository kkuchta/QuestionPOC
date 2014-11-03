class CreateQuestionSets < ActiveRecord::Migration
  def change
    create_table :question_sets do |t|
      t.integer :head_question_id
      t.string :slug

      t.timestamps
    end
  end
end
