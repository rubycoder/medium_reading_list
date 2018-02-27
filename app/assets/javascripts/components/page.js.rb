class Page < FerroDocument
  def cascade
    add_child :header, FerroElementHeader
    header.add_child :title, FerroElementText, content: "My little scrapper", size: 1
    header.add_child :subtitle,FerroElementText, content: "Medium - Ruby", size: 2

    add_child :articles, FerroElementNavigation
    add_child :reading_list, ReadingList

    scrap :ruby
  end

  def scrap(tag)
    FerroXhr.new "tag/#{tag}",
      -> (response)    { build_articles(response[:articles]) },
      -> (status, msg) { puts "Uh-oh" },
      timeout: 10000
  end

  def build_articles(list)
    list.each_with_index do |article, index|
      articles.add_child "article_#{index}", Article, article
    end
  end

  def toggle_article(article)
    reading_list.toggle_article article
  end
end
