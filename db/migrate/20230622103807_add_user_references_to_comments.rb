class AddUserReferencesToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :user, foreign_key: true

    Comment.find_each do |comment|
      comment.update!(user_id: comment.author_id + 1)
    end

    change_column_null(:comments, :user_id, false)
  end
end
