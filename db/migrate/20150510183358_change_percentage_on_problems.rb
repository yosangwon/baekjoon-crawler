class ChangePercentageOnProblems < ActiveRecord::Migration
  def up
    add_column :problems, :temp, :integer

    Problem.find_each do |problem|
      problem.temp = (problem.percentage * 100).to_i
      problem.save!
    end

    remove_column :problems, :percentage
    rename_column :problems, :temp, :percentage
  end

  def down
    add_column :problems, :temp, :float

    Problem.find_each do |problem|
      problem.temp = problem.percentage.to_f / 1000
      problem.save!
    end

    remove_column :problems, :percentage
    rename_column :problems, :temp, :percentage

  end
end
