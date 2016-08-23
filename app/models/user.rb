class User < ApplicationRecord
    devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :sshkeys
    has_many :cards

    has_many :books, through => :book_purchases
    has_many :book_purchases

    has_many :plans, through => :plan_purchases
    has_many :plan_purchases
end
