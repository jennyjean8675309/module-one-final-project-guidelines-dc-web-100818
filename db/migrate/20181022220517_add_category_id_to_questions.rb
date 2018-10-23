class AddCategoryIdToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :category_id, :integer
  end
end
