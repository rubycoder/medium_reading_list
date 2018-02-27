require 'medium_scrapper'

class PagesController < ApplicationController
  def home
  end

  def scrap
    render json: { articles: MediumScrapper.articles_for(tag: params[:tag]) }.to_json
  end
end
