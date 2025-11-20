class Post < ApplicationRecord
  belongs_to :customer
  belongs_to :course
  has_many :post_comments, dependent: :destroy

  validates :round_day, presence:true
  validates :golf_score, presence:true, length:{maximum:3}
  validates :sentence, presence:true, length:{maximum:200}
  validates :score, presence:true

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :difficulty, -> {order(score: :desc)}
  scope :ease, -> {order(score: :asc)}

  # 平均ゴルフスコア計算用
  scope :latest_round_day, -> {order(round_day: :desc)}
end
