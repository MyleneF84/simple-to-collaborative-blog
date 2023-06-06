class MigrateArticlesToContributions < ActiveRecord::Migration[7.0]
  def up
    Article.find_each do |article|
      Contribution.create!(article_id: article.id, author_id: article.author_id)
    end
    remove_reference :articles, :author, index: true, foreign_key: true
  end

  def down
    add_reference :articles, :author, foreign_key: true
    Contribution.find_each do |contribution|
      Article.where(id: contribution.article_id).update(author_id: contribution.author_id)
      contribution.delete
    end
  end
end
