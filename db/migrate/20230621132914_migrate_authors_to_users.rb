class MigrateAuthorsToUsers < ActiveRecord::Migration[7.0]
  def up
    Author.find_each do |author|
      user = User.new(author.attributes.except("id"))
      user.password = "qwerty"
      user.save!
    end
  end
end
