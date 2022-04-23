class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum priority: { low: 0, medium: 1, high: 2 }
  scope :ordered, -> { order(created_at: :desc) }
end
