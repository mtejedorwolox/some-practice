class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :user_id, :text, presence: true

  alias_attribute :asker, :user
end
