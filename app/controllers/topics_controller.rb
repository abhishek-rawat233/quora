class TopicsController < ApplicationController
  before_action :check_api_calls, only: :show
  after_action :set_api_call_record, only: :show

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.eager_load(:questions).find_by(name: params[:id])
    @questions = @topic.questions
    render json: @topic, include: :questions
  end

  def check_api_calls
    api_registered = ApiRegister.where(ip_address: request.remote_ip, created_at: 1.hour.ago..Time.current)
    if api_registered.count >= MAXIMUM_API_PER_HOUR_CALLS
      access_time = api_registered.first.created_at + 1.hour
      redirect_to topics_path, notice: 'maximum api calls per hour hit. Try after' + access_time.to_s
    end
  end

  def set_api_call_record
    ApiRegister.create(set_api_params)
  end

  def set_api_params
    {
      api_type: :public_api,
      url: request.path,
      ip_address: request.remote_ip
    }
  end
end
