class AdjustmentController < ApplicationController

  before_filter :check_for_cancel, :only => [:create]

  def new
    adjustment = Adjustment.new()
    adjustment_codes = AdjustmentCode.all.map { |i| [i.short_name, i.id]}
    scheduled_group = ScheduledGroup.find(params[:group_id])
    liaison_name = Liaison.find(scheduled_group.liaison_id).name
    site_name = Site.find(Session.find(scheduled_group.session_id).site_id).name
    period_name = Period.find(Session.find(scheduled_group.session_id).period_id).name
    start_date = Period.find(Session.find(scheduled_group.session_id).period_id).start_date
    end_date = Period.find(Session.find(scheduled_group.session_id).period_id).end_date
    session_type = SessionType.find(Session.find(scheduled_group.session_id).session_type_id).name

    @screen_info = {:scheduled_group => scheduled_group,
      :site_name => site_name, :period_name => period_name, :start_date => start_date,
      :end_date => end_date,  :session_type => session_type, :adjustment => adjustment, :adjustment_codes => adjustment_codes,
      :liaison_name => liaison_name}

    @title = "Record payment for: #{scheduled_group.name}"
  end

  def create

    adjustment = Adjustment.new(params[:adjustment])
    scheduled_group = ScheduledGroup.find(adjustment.group_id)

    if adjustment.valid?
      adjustment.save!
      flash[:notice] = "Successful entry of new adjustment"
      redirect_to myssp_path(:id => scheduled_group.liaison_id)
    else

      adjustment_codes = AdjustmentCode.all.map { |i| [i.short_name, i.id]}
      scheduled_group = ScheduledGroup.find(params[:adjustment][:group_id])
      liaison_name = Liaison.find(scheduled_group.liaison_id).name
      site_name = Site.find(Session.find(scheduled_group.session_id).site_id).name
      period_name = Period.find(Session.find(scheduled_group.session_id).period_id).name
      start_date = Period.find(Session.find(scheduled_group.session_id).period_id).start_date
      end_date = Period.find(Session.find(scheduled_group.session_id).period_id).end_date
      session_type = SessionType.find(Session.find(scheduled_group.session_id).session_type_id).name

      @screen_info = {:scheduled_group => scheduled_group,
        :site_name => site_name, :period_name => period_name, :start_date => start_date,
        :end_date => end_date,  :session_type => session_type, :adjustment => adjustment, :adjustment_codes => adjustment_codes,
        :liaison_name => liaison_name}
      @title = "Record payment for: #{scheduled_group.name}"
      render "adjustment/new"
    end
  end

private
  def check_for_cancel
   unless params[:cancel].blank?
     liaison_id = ScheduledGroup.find(params[:adjustment][:group_id]).liaison_id
    redirect_to myssp_path(liaison_id)
   end
  end

end