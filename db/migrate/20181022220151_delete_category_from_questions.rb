class DeleteCategoryFromQuestions < ActiveRecord::Migration[5.0]
  def change
    remove_column :questions, :category
  end
end
