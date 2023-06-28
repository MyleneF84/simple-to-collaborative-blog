class CreateAccess < ActiveRecord::Migration[7.0]
  def change
    create_table :accesses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :space, null: false, foreign_key: true

      t.timestamps
    end
  end
end
