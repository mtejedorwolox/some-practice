class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :text, :provider

  def provider
    UserSerializer.new(object.provider)
  end

  # TODO: check why belongs_to :provider doesn't work like belongs_to :asker
end
