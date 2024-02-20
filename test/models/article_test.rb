require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "should not save article without title or content" do
    article = Article.new
    assert_not article.save
  end

  test "should allow group_id to be nil" do
    article = articles(:two)
    assert article.valid?, article.errors.full_messages.inspect
  end

  test "should save article if group_id is nil" do
    article = articles(:two)
    assert article.save
  end


  # test "author should be current_author when article saved without assigned group" do
  #   article = Article.new
  #   article.group = nil
  #   # article.contributions = Contribution.new( author_id: Author.first.id)
  #   article.save
  #   contribution = Contribution.new(article_id: article.id, author_id: Author.first.id)
  #   contribution.save

  #   assert_equal 1, article.contributions.first.author.id
  # end
end
