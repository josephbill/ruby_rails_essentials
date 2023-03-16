class Article < ApplicationRecord
  has_many :comments
  validates :title, presence: true 
  validates :body, presence:true, length: {minimum: 7}

  validate :titleisunique
  validate :body_shouldnothavecursewords

  private 
  def titleisunique
    if Article.where("title = ? AND created_at >= ?", self.title, Time.zone.now.beginning_of_month).any?
      errors.add(:title, "has already been taken this month.")
    end
  end 

  private
  def body_shouldnothavecursewords 
    if self.body && self.body.match(/(damn|curseword)/i)
      errors.add(:body, "contains a curse word.")
    end    
  end
end
