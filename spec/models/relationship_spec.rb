# require 'rails_helper'

# RSpec.describe Relationship, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

# spec/models/relationship_spec.rb
require 'rails_helper'

# Test suite for the Relationship model
RSpec.describe Relationship, type: :model do
  # Association test
  # ensure Relationship model belongs to a single User model
  # it { should belong_to(:user) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:following_id) }
  it { should validate_presence_of(:follower_id) }
end