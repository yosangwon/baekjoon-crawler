class CreateBaekjoonUsers < ActiveRecord::Migration
  def change
    create_table :baekjoon_users do |t|
      t.string :slug, default: 0, null: false, index: true
      t.text :info
      t.integer :trial, default: 0, null: false
      t.integer :success, default: 0, null: false
      t.integer :fail, default: 0, null: false

      t.timestamps null: false
    end
  end
end
