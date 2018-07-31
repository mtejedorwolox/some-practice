class Question < ApplicationRecord
  belongs_to :user
  has_many :answers

  validates :user_id, :text, presence: true

  alias_attribute :asker, :user
end
