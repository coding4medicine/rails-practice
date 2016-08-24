class Book < ApplicationRecord
    has_many :users, through: :book_purchases
    has_many :book_purchases
end
