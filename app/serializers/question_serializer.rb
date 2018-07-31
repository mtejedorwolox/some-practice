class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :text

  has_many :answers
  belongs_to :asker
end
