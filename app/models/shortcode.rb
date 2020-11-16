require 'uri'

class Shortcode < ApplicationRecord
    validates :original_url, presence: true,
                             uniqueness: {scope: :original_url, message: "Entry already exists"},
                             format: { with: /((http|https):\/\/)(([a-z0-9-\.]*)\.)?([a-z0-9-]+)\.([a-z]{2,5})(:[0-9]{1,5})?(\/)?/, message: "Valid URLs only" }

    CHAR_MAP = [*'a'..'z', *'A'..'Z', *'0'..'9'].freeze

    def get_short_url
        @shortcode = ""
        x = self[:original_url].length * rand(128...254)
        puts x
        while x > 0
            @shortcode = @shortcode + CHAR_MAP[x%62]
            x = x/62
        end
        self[:short_url] = @shortcode
    end
end
