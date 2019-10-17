class Product < ApplicationRecord

	validates :description, :image_url, presence: true
	validates :price, numericality: { greater_than_or_equal_to: 0.01 }
	validates :title, uniqueness: true, allow_blank: true, :length => {minimum: 10}
	validates_presence_of :title, message: "this is necessary"
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\z}i,
		message: 'must be a url for GIF,JPG, or PNG image'
	}
end
