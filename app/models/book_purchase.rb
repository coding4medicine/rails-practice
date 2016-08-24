class BookPurchase < ApplicationRecord
    belongs to :user
    belongs to :book
end
