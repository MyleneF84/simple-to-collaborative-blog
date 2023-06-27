class AddReferencesUserToContributions < ActiveRecord::Migration[7.0]
  def change
    add_reference :contributions, :user, foreign_key: true

    Contribution.find_each do |contribution|
      contribution.update!(author_id: rand(2..17))
    end

    change_column_null(:contributions, :user_id, false)
  end
end
