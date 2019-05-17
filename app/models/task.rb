class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :title, length: { maximum: 20 }  
  validates :content, presence: true
  validates :content, length: { maximum: 50 }  
  validate :end_limit_cannot_be_in_the_past

  def end_limit_cannot_be_in_the_past
    if end_limit.present? && end_limit < Date.today
      errors.add(:end_limit, ": 過去の日付は使えません")
    end
  end
end