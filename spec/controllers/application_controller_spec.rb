require 'rails_helper'

describe ApplicationController, type: :controller do
  describe 'GET #questions' do
    let(:answer) { create(:answer, :with_public_question) }

    context 'without tenant api_key' do
      it 'responds with status unauthorized' do
        get :questions
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with invalid tenant api_key' do
      it 'responds with status unauthorized' do
        get :questions, params: { api_key: Faker::Crypto.md5 }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with a valid tenant api_key' do
      context 'without public questions' do # rubocop:disable NestedGroups
        let(:other_answer) { create(:answer, :with_private_question) }
        it 'responds with status not found' do
          get :questions, params: { api_key: other_answer.question.tenant.api_key }
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'with public questions' do # rubocop:disable NestedGroups
        let(:other_question) { create(:question, :private, tenant: answer.question.tenant) }

        context 'without matching terms' do # rubocop:disable NestedGroups
          it 'responds with status not found' do
            get :questions, params: { api_key: answer.question.tenant.api_key,
                                      terms: Faker::Lorem.words(2, true) }
            expect(response).to have_http_status(:not_found)
          end
        end

        context 'with matching terms' do # rubocop:disable NestedGroups
          it 'responds with status ok' do
            get :questions, params: { api_key: answer.question.tenant.api_key,
                                      terms: answer.question.text.split(' ').sample(2) }
            expect(response).to have_http_status(:ok)
          end
        end

        it 'filters the private questions' do
          get :questions, params: { api_key: other_question.tenant.api_key }
          expect(JSON.parse(response.body).size).to eq(1)
        end
      end
    end
  end

  describe 'GET #index' do
    let!(:answers) { create_list(:answer, 4) }

    it 'users_count is set' do
      get :index
      assert_equal 8, assigns(:users_count)
    end

    it 'answers_count is set' do
      get :index
      assert_equal 4, assigns(:answers_count)
    end

    it 'questions_count is set' do
      get :index
      assert_equal 4, assigns(:questions_count)
    end

    it 'tenants is set' do
      get :index
      assert_equal answers.map { |answer| answer.question.tenant }, assigns(:tenants)
    end
  end
end
