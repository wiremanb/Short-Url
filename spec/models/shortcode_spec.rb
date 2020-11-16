require 'rails_helper'

RSpec.describe Shortcode, type: :model do
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:original_url) }
end