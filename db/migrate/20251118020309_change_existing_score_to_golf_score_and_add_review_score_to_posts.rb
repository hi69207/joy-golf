class ChangeExistingScoreToGolfScoreAndAddReviewScoreToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :score, :golf_score
    add_column :posts, :score, :integer, null: false, default: 5
  end
end
