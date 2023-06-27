class RemoveReferenceInComments < ActiveRecord::Migration[7.0]
  def change
    remove_reference :comments, :author, foreign_key: true
  end
end
