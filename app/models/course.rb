class Course < ApplicationRecord
  has_one_attached :course_image
  belongs_to :prefecture
  has_many :posts, dependent: :nullify

  def status_text
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
