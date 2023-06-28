class CreateTableSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :spaces do |t|
      t.string :name

      t.timestamps
    end
  end
end
