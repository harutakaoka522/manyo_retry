class Task < ApplicationRecord
  belongs_to :user, optional: true
  has_many :task_labels, dependent: :destroy, inverse_of: :task
  has_many :labels, through: :task_labels, source: :label

  validates :title, presence: true
  validates :title, length: { maximum: 20 }  
  validates :content, presence: true
  validates :content, length: { maximum: 50 }  
  validate :end_limit_cannot_be_in_the_past

  enum priority: {'高':0,'中':1,'低':2}
  
  def end_limit_cannot_be_in_the_past
    if end_limit.present? && end_limit < Date.today
      errors.add(:end_limit, ": 過去の日付は使えません")
    end
  end
end


# id = 1
# task = Task.find(id)
# task.labels = TaskLabel.where(task_id: id).map do |task_label|
#   Label.find(task_label.label_id)
# end

# has_many(:tasks, foreign_key: :user_id, dependent: :destroy)
#   def has_many(arg1)
#      self.arg1 =  Arg1.where(arg1_id: self.id)
#   end

#   def has_many(tasks)
#     self.tasks =  Task.where(user_id: self.id)
#   end