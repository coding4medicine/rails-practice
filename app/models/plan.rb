class Plan < ApplicationRecord
    has_many :users, through: :buy_plans
    has_many :buy_plans
end
