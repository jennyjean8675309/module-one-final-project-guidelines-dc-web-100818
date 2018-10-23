class CreateChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :choices do |t|
      t.string :name
      t.boolean :correct?
      t.integer :question_id
    end
  end
end
