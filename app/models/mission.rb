class Mission < ApplicationRecord
  belongs_to :user
  belongs_to :coder

  validates :title, presence: true
  # validates :start_date, presence: true
  # validates :end_date, presence: true, date: { after_or_equal_to: :start_date }
end

