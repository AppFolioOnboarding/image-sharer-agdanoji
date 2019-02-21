class Image < ApplicationRecord
  validates :url, presence: true
  validates :url, format: { with: /\A(http|https)/, message: 'You have an invalid url' }
  validates :url, format: { with: /\.(jpe?g|gif|png)/, message: 'Must have valid  extention' }
end
