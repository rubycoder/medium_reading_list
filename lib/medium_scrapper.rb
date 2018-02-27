require 'open-uri'

class MediumScrapper
  def self.articles_for(tag:)
    posts = Nokogiri::HTML(open("https://medium.com/tag/#{tag}/latest")).css('.postArticle-content')
    posts.map do |post|
      image = post.css('img')
      {
        title: post.css('h3.graf--title').inner_text,
        body: post.css('p, h4, h3:not(.graf--title)').map(&:inner_text).join("\n"),
        source_url: post.ancestors('a').attribute('href').value,
        image_url: image.present? && image.attribute('src').value,
        reading_time: post.ancestors('.postArticle').css(".readingTime").attribute('title').value.split[0].to_i
      }
    end
  end
end
