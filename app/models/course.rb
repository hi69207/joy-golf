class Course < ApplicationRecord
  has_one_attached :course_image
  belongs_to :prefecture
  has_many :posts, dependent: :nullify

  validates :name, presence:true, length:{maximum:20}, uniqueness: true
  validates :address, presence:true
  validates :latitude, presence:true
  validates :longitude, presence:true

  def course_state
    if is_active
      "有効"
    else
      "退会"
    end
  end

  def get_course_image
    unless course_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      course_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      course_image
  end
end
