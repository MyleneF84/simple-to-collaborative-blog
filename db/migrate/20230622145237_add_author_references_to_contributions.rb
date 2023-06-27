class AddAuthorReferencesToContributions < ActiveRecord::Migration[7.0]
  def change
    remove_column :contributions, :user_id
    add_reference :contributions, :author, foreign_key: {to_table: :users}

  end
end
