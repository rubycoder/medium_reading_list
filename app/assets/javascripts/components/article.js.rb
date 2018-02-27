class Article < FerroElementBlock
  attr_reader :link, :reading_time

  def cascade
    @link = @options[:source_url]
    @reading_time = @options[:reading_time]
    add_child :title, FerroElementText, size: 3, content: @options[:title]
    add_child :image, FerroElementImage, src: @options[:image_url], width: '500px' if @options[:image_url]
    add_child :body, FerroElementText, content: @options[:body]
    add_state :selected, false

    Element.find(@element).on :click, &method(:clicked)
  end

  def get_title
    title.get_text
  end

  def clicked
    root.toggle_article self
  end
end
