class Book < ApplicationRecord
    has_many :users, through: :buy_book
    has_many :buy_book
end
