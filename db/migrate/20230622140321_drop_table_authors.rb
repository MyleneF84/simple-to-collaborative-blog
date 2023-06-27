class DropTableAuthors < ActiveRecord::Migration[7.0]
  def change
    drop_table :authors
  end
end
