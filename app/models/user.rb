class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :birth_date, :sex, presence: true
  validates :nickname, presence: true, length: { minimum: 1 ,maximum:20  }
  validates :password, presence: true, length: { minimum: 6 ,maximum:128 }
  validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },uniqueness: true

  has_one :address
  has_many :items, dependent: :destroy
end
