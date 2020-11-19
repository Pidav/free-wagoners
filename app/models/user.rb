class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :coders
  has_many :missions
  has_one_attached :photo

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :phone_number, format: { with: /\A(0|\+33[\s-]?)[1-9][\s-]?(\d{2}[\s-]?){4}\z/, message: "uniquement + ou des nombres" }
end
