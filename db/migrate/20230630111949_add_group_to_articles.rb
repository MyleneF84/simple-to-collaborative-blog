class AddGroupToArticles < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :group, foreign_key: true
  end
end
