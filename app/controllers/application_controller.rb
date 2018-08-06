class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # i18n configuration. See: http://guides.rubyonrails.org/i18n.html
  before_action :set_locale, :authenticate_request, except: :index

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: locale }
  end

  # for devise to redirect with locale
  def self.default_url_options(options = {})
    options.merge(locale: I18n.locale)
  end

  def index
    @users_count = User.count
    @answers_count = Answer.count
    @questions_count = Question.count
    @tenants = Tenant.all
  end

  def questions
    questions = @tenant.questions.includes(:user, answers: [:user])
                       .is_public
                       .terms(params[:terms])
    return head :not_found if questions.empty?
    render json: questions,
           include: 'asker,answers,answers.provider',
           status: :ok
  end

  private

  def authenticate_request
    @tenant = Tenant.find_by(api_key: params['api_key'])
    return head :unauthorized if @tenant.blank?
    @tenant.increment(:request)
  end
end
