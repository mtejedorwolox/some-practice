class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :text, :provider

  belongs_to :provider
end
