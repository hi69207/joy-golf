class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  belongs_to :prefecture
  has_many :posts, dependent: :destroy

  validates :name, presence:true, length:{maximum:20}, uniqueness: true
  validates :address, presence:true
  validates :history, presence:true

  def customer_state
    if is_active == true
      "有効"
    else
      "退会"
    end
  end

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image
  end
end
