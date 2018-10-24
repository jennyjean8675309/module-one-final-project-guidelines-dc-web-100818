class AddDifficultyToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :difficulty, :string
  end
end
