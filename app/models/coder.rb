class Coder < ApplicationRecord
  belongs_to :user
  has_many :missions

  validates :price_per_day, presence: true, inclusion: { in: (1..10000)}
  validates :email, format: { with: /^.@.\.com\z$/, message: "email valide uniquement" }
  validates :phone_number, format: { with: /^(\+33\s[1-9]{8})|(0[1-9]\s{8})$/, message: "uniquement + ou des nombres" }
  validates :description,  length: { minimum: 100 }
end
