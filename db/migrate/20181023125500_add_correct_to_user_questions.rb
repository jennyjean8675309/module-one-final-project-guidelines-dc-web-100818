class AddCorrectToUserQuestions < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_questions, :correct?
    add_column :user_questions, :correct, :boolean
  end
end
