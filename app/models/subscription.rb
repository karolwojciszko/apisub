class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :channel, optional: true
  belongs_to :show, optional: true
end
