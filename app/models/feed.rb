class Feed < ApplicationRecord
  has_many :items, dependent: :destroy
  URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates :url, format: { with: URL_REGEXP, message: 'You provided invalid URL' }

end
