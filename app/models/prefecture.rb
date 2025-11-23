class Prefecture < ApplicationRecord
  has_one_attached :prefecture_image
  has_many :customers, dependent: :nullify
  has_many :courses, dependent: :nullify

  validates :name, presence: true, length:{maximum:20}, uniqueness: true
  validates :latitude, presence:true
  validates :longitude, presence:true

  def get_prefecture_image
    unless prefecture_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      prefecture_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      prefecture_image.variant(resize_to_fill: [600, 600], gravity: 'center')
  end
end
