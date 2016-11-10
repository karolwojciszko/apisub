class Show < ApplicationRecord
  belongs_to :category
  belongs_to :channel, optional: true
end
