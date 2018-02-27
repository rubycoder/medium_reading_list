class ReadingList < FerroElementAside
  def cascade
    add_child :title, FerroElementText, size: 4, content: 'Reading List'
    add_child :container, FerroElementNavigation
    add_child :total_reading_time, FerroElementText, class: 'total-reading-time'
    total_reading_time.add_state :hidden, true

    @articles ||= []
  end

  def toggle_article(article)
    if @articles.index(article)
      @articles.delete(article)
    else
      @articles << article
    end

    update_list
  end

  private

  def update_list
    container.children.dup.each do |name, child|
      child.destroy
      child.source.toggle_state :selected
    end

    @articles.each_with_index do |article, index|
      container.add_child "article_#{index}", ShortArticle, source: article
      article.toggle_state :selected
    end

    update_reading_time
  end

  def update_reading_time
    total_time = @articles.map(&:reading_time).reduce(&:+)
    total_reading_time.set_text "Remaining read time: #{total_time} mns"
    total_reading_time.update_state :hidden, @articles.none?
  end
end
