class UpdateTitleJob < ApplicationJob
  queue_as :default

  def perform(short_url_id)
    @shortcode = Shortcode.find(short_url_id)
    @shortcode.update(title: @shortcode.original_url)
  end
end
