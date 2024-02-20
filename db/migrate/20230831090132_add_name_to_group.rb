class AddNameToGroup < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :name, :string

    Group.find_each { |group| group.update!(name: "") }

    change_column_null(:groups, :name, false)
  end
end
