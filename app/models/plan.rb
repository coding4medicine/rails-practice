class Plan < ApplicationRecord
    has_many :users, through: :plan_purchases
    has_many :plan_purchases
end
