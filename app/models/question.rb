class Question < ApplicationRecord
  belongs_to :user
  belongs_to :tenant
  has_many :answers, dependent: :destroy

  validates :user_id, :tenant_id, :text, presence: true

  alias_attribute :asker, :user

  scope :terms, lambda { |terms|
    return all unless terms
    terms = terms.map { |term| term.strip.downcase }
    where((['lower(text) like ?'] * terms.size).join(' AND '), *terms.map { |term| "%#{term}%" })
  }

  scope :is_public, lambda { where(is_private: false) }
end
