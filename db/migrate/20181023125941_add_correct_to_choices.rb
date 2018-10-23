class AddCorrectToChoices < ActiveRecord::Migration[5.0]
  def change
    remove_column :choices, :correct?
    add_column :choices, :correct, :boolean
  end
end
