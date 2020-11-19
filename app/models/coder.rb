class Coder < ApplicationRecord
  belongs_to :user
  has_many :missions
  has_many :reviews, through: :missions
  has_one_attached :photo

  validates :name, presence: true, uniqueness: true
  validates :price_per_day, presence: true, inclusion: { in: (1..10_000) }
  validates :email, format: { with: /\A([^@]+)@([^@]+)\.(\w+)\z/, message: "email valide uniquement" }
  validates :phone_number, presence: true
  validates :phone_number, format: { with: /\A(0|\+33[\s-]?)[1-9][\s-]?(\d{2}[\s-]?){4}\z/, message: "uniquement + ou des nombres" }
  validates :description,  length: { minimum: 100 }
end
