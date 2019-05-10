class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
#  validates :end_limit, presence: true
 # validates :priority, presence: true
 # validates :status, presence: true


  validate :end_limit_cannot_be_in_the_past

  def end_limit_cannot_be_in_the_past
    if end_limit.present? && end_limit < Date.today
      errors.add(:end_limit, ": 過去の日付は使えません")
    end
  end

end