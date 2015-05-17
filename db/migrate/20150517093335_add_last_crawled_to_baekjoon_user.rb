class AddLastCrawledToBaekjoonUser < ActiveRecord::Migration
  def change
    add_column :baekjoon_users, :last_crawled, :integer
  end
end
