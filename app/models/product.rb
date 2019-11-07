class Product < ApplicationRecord
	has_many :line_items
	has_many :orders, through: :line_items
	before_destroy :ensure_not_referenced_by_any_line_item
	validates :description, :image_url, presence: true
	validates :price, numericality: { greater_than_or_equal_to: 0.01 }
	validates :title, uniqueness: true, allow_blank: true, :length => {minimum: 10}
	validates_presence_of :title, message: "this is necessary"
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\z}i,
		message: 'must be a url for GIF,JPG, or PNG image'
	}

	private

	def ensure_not_referenced_by_any_line_item   #it is hook method
		unless line_items.empty?
			errors.add(:base, 'Line Items present')   #this validation error associate with base object
			throw :abort
		end
	end
end
