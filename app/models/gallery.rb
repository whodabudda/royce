class Gallery < ApplicationRecord
	has_many :gallery_pictures
	has_many :pictures, through: :gallery_pictures
end
