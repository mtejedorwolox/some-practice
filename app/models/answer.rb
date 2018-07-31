class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :user_id, :question_id, :text, presence: true

  alias_attribute :provider, :user
end
