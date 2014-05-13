class Vote < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  enum direction: [:up, :down]
  scope :recent, -> { where(created_at: 1.week.ago..Time.now) }
  validates :user_id, uniqueness: { scope: :post_id, message: 'You have already voted on this post' }

  after_create :send_email

  def send_email
    VoteMailer.notification(self, post).deliver
  end

end
