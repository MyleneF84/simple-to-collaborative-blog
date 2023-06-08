class AddEmailToAuthors < ActiveRecord::Migration[7.0]
  def change
    add_column :authors, :email, :string

    Author.all.each.with_index do |author, i|
      author.email = "mail#{i}@gmail.com"
      author.save!
    end

    change_column_null(:authors, :email, false)
  end
end
