class CreateContributions < ActiveRecord::Migration[7.0]
  def change
    create_table :contributions do |t|
      t.references :article, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
