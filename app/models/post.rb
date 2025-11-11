class Post < ApplicationRecord
  belongs_to :customer
  belongs_to :course

  validates :round_day, presence:true
  validates :score, presence:true, length:{maximum:3}
  validates :sentence, presence:true, length:{maximum:200}
end
