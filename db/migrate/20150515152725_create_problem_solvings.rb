class CreateProblemSolvings < ActiveRecord::Migration
  def change
    create_table :problem_solvings do |t|
      t.integer :problem_id, default: 0, null: false, index: true
      t.integer :baekjoon_user_id, default: 0, null: false, index: true
      t.boolean :solved, default: false, null: false

      t.timestamps null: false
    end
  end
end
