class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :end_limit, presence: true
  validates :priority, presence: true
  validates :status, presence: true
end