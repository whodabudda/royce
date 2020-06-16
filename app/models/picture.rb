class Picture < ApplicationRecord
	has_one_attached :image
	has_many :gallery_pictures
	has_many :galleries , through: :gallery_pictures

end
