class GalleryPicture < ApplicationRecord
  belongs_to :gallery, optional: true
  belongs_to :picture, optional: true
end
