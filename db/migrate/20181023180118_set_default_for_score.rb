class SetDefaultForScore < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :score, 0
  end
end
