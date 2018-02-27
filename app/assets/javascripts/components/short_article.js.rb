class ShortArticle < FerroElementText
  attr_reader :source

  def cascade
    @source = @options[:source]
    add_child :link, FerroElementExternalLink, content: source.get_title, href: @source.link
    add_child :reading_time, FerroElementText, content: "#{source.reading_time} min."
    add_child :remove, Remove, content: 'x', class: 'remove'
  end

  def toggle_off
    parent.parent.toggle_article @source
  end

  class Remove < FerroElementAnchor
    def clicked
      parent.toggle_off
    end
  end
end
