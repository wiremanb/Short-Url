require 'open-uri'
require 'nokogiri'

class UpdateTitleJob < ApplicationJob
  queue_as :default

  def perform(short_url_id)
    @shortcode = Shortcode.find(short_url_id)
    @shortcode.update(title: Nokogiri::HTML.parse(open(@shortcode.original_url)).title)
  end
end
