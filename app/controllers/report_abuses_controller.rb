class ReportAbusesController < ApplicationController
  before_action :set_report

  def create
    if @report_abusive.save
      flash[:notice] = 'marked as abusive'
    else
      flash[:notice] = @report_abusive.errors.full_messages
    end
    redirect_to user_home_path(params[:base_user_id])
  end

  def set_report
    @report_abusive = ReportAbuse.new(report_abusive_params)
  end

  def report_abusive_params
    params.permit(:abusable_id, :abusable_type, :base_user_id)
  end
end
