ActiveRecord::Base.transaction do
  # 3 sample users
  users = FactoryBot.create_list(:user, 3)
  # 3 sample tenants
  tenants = FactoryBot.create_list(:tenant, 3)
  tenants.each do |tenant|
    # 4 questions per tenant with random asker and random private property
    questions = FactoryBot.create_list(:question, 4, user: users.sample, tenant: tenant)
    questions.each do |question|
      # 3 answers per question with random provider
      FactoryBot.create_list(:answer, 3, user: users.sample, question: question)
    end
  end
end
