ActiveRecord::Base.transaction do
  user = FactoryBot.create(:user)
  question = FactoryBot.create(:question, user: user, is_private: false)
  answer1 = FactoryBot.create(:answer, user: user, question: question)
  answer2 = FactoryBot.create(:answer, user: user, question: question)
end
