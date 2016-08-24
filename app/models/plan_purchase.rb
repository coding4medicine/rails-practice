class PlanPurchase < ApplicationRecord
    belongs to :user
    belongs to :plan
end
