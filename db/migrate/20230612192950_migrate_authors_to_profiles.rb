class MigrateAuthorsToProfiles < ActiveRecord::Migration[7.0]
  def up
    Author.find_each do |author|
      profile = Profile.create!(first_name: author.first_name, last_name: author.last_name)
      author.profile_id = profile.id
      author.save!
    end
    remove_columns :authors, :first_name, :string, :last_name, :string
  end

  def down
    add_columns :authors, :first_name, :string, :last_name, :string

    Profile.find_each do |profile|
      author = Author.where(profile_id: profile.id)
      author.update!(first_name: profile.first_name, last_name: profile.last_name)
    end
  end
end
