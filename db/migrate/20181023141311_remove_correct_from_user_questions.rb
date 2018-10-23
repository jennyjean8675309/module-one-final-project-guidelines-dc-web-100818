class RemoveCorrectFromUserQuestions < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_questions, :correct
  end
end
