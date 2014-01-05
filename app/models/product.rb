class Product < ActiveRecord::Base

	has_many :line_items

    before_destroy :ensure_not_referenced_by_any_line_item

    validates :title, presence: true, uniqueness: true, length: {maximum: 100}
    validates :description, presence: true, length: {maximum: 1000}


    validates :price, :format => { :with => /\A\d+??(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0, :less_than => 100000}



	def self.latest
		Product.order(:updated_at).last
	end

	private
	# ensure that there are no line items referencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line items present')
			return false
		end
	end


end

