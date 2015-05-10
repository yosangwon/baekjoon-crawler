class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.integer :code
      t.string :title
      t.integer :trial
      t.integer :success
      t.float :percentage

      t.timestamps null: false
    end
  end
end
