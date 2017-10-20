class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators
end
