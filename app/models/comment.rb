# == Schema Information
#
# Table name: comments
#
#  id                :bigint           not null, primary key
#  body              :string           not null
#  author_id         :integer          not null
#  video_id          :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Comment < ApplicationRecord
  validates :body, :author_id, :video_id, presence: true

  has_many :replies, foreign_key: :parent_comment_id, class_name: :Comment
  has_many :votes, as: :votable
  belongs_to :author, class_name: :User
  belongs_to :video

  def vote_count
    self.votes.where(is_upvoted: true).count - self.votes.where(is_upvoted: false).count
  end
end
