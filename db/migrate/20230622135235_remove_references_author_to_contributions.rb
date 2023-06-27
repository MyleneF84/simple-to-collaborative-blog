class RemoveReferencesAuthorToContributions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :contributions, :author, foreign_key: true
  end
end
