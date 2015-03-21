class PreregsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    @prereg = Prereg.find(params[:id])
  end

  def new
    # @event = Event.find(params[:event_id])
    @prereg = Prereg.new(params[:prereg])
    # @prereg.event_id = @event.id
  end

  def create

    # prereg = Prereg.find_or_create_by_user_id_and_event_id!(
    #   :user_id => current_user.id,
    #   :event_id => params[:event_id])

    @prereg = Prereg.new(params[:prereg])
    puts params
    if @prereg.save && @prereg.deliver_prereg
      flash[:success] = "Thanks! We'll send you an email when #{@prereg.event.host_firstname} has set a new date for #{@prereg.event.topic}."
      if @prereg.event.is_a?(Workshop)
        redirect_to workshop_url(@prereg.event_id)
      else
        redirect_to apprenticeship_url(@prereg.event_id)
      end
    end
  end

  def destroy
    @prereg = Prereg.find(params[:id])
    @event = @prereg.event
    @prereg.destroy
    flash[:warning] = "You have successfully unfollowed #{@event.title}."
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end