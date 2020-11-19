class Coder < ApplicationRecord
  has_many :missions
  belongs_to :user
  has_many :reviews, through: :missions
  has_one_attached :photo
  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :description ],
    associated_against: {
      missions: [ :title, :description ]
    },
    using: {
      tsearch: { prefix: true }
    }

  validates :name, presence: true, uniqueness: true
  validates :price_per_day, presence: true, inclusion: { in: (1..10_000) }
  validates :email, format: { with: /\A([^@]+)@([^@]+)\.(\w+)\z/, message: "email valide uniquement" }
  validates :phone_number, presence: true
  validates :phone_number, format: { with: /\A(0|\+33[\s-]?)[1-9][\s-]?(\d{2}[\s-]?){4}\z/, message: "uniquement + ou des nombres" }
  validates :description,  length: { minimum: 100 }
end
