class Tenant < ApplicationRecord
  has_many :questions, dependent: :destroy

  validates :name, :api_key, presence: true
end
