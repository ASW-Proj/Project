class Post < ApplicationRecord
    validates :title, presence: true, :length => {
        :minimum => 4,
        :maximum => 255,
        :too_short => "must have at least %{count} characters",
        :too_long  => "must have at most %{count} characters",
    }
    has_many :comments
    belongs_to :community
    belongs_to :user

    has_many :votes, as: :votable

    def total_votes
        self.votes.count
      end


    has_many :saved_posts, dependent: :destroy
  has_many :savers, through: :saved_posts, source: :user

end
