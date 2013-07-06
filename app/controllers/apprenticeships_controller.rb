class ApprenticeshipsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :current_apprenticeship, except: [:index, :new, :create, :save]
  before_filter :owner_user, only: [:edit, :private, :payment, :payment_confirmation, :update]
  before_filter :current_admin, only: :destroy
  before_filter :load_user_gallery

  def index
    unless current_user.blank?
      @allpending_apprenticeships = Apprenticeship.find_all_by_state('pending')
      @allsaved_apprenticeships = Apprenticeship.find_all_by_state('started')
      @allcanceled_apprenticeships = Apprenticeship.find_all_by_state('canceled')
      @allfilled_apprenticeships = Apprenticeship.find_all_by_state('filled')
      @allcompleted_apprenticeships = Apprenticeship.find_all_by_state('completed')
    end
  	@apprenticeships = Apprenticeship.find_all_by_state(['accepted','filled','completed'])
  end

  def create
    if params[:apprenticeship]
      @apprenticeship = current_user.apprenticeships.new(params[:apprenticeship])
    else
      @apprenticeship = current_user.apprenticeships.new(topic: 'A New Apprenticeship', host_firstname: current_user.first_name, host_lastname: current_user.last_name, datetime_tba: true)
    end
    @apprenticeship.begins_at ||= Date.today
    @apprenticeship.ends_at ||= Date.tomorrow
    @apprenticeship.generate_title

    if @apprenticeship.save(validate: false) && @apprenticeship.deliver_save
      redirect_to edit_apprenticeship_path(@apprenticeship), :flash => { :success => "Nice! Let's start by designing your apprenticeship. We'll save this form as you go so you can come back to it at any time." }
    else
      flash.now[:warning] = "Whoops! There was a problem starting your apprenticeship: #{@apprenticeship.errors.full_messages}"
      flash.now[:error] = @apprenticeship.errors.full_messages
      render 'info'
    end
  end

  def update
    if params[:name] && params[:value]
      if @apprenticeship.respond_to?(params[:name])
        if @apprenticeship.xeditable_update(params[:name], params[:value])
          respond_to do |format|
            format.json { render json: {event: @apprenticeship, checkmarks: @apprenticeship.checkmarks } and return }
          end
        else
          respond_to do |format|
              format.json { render json: { errors: @apprenticeship.errors[params[:name].to_sym].first } and return }
          end
        end
      end
    else
      if params[:apprenticeship]
        @apprenticeship.attributes = params[:apprenticeship]
        @apprenticeship.save(validate: false)

        if params[:revoke_button]
          if current_user.admin? && @apprenticeship.revoke && @apprenticeship.deliver_revoke
            redirect_to apprenticeships_path, :flash => { :warning => "Apprenticeship revoked."} and return
          end

        elsif params[:reject_button]
          if current_user.admin? && @apprenticeship.reject && @apprenticeship.deliver_reject
            redirect_to apprenticeships_path, :flash => { :warning => "Apprenticeship rejected." } and return
          end

        elsif params[:commit] == 'Save'
          redirect_to :back, flash: { success: "Your apprenticeship has been saved"} and return

        elsif params[:apprenticeship][:stripe_card_token] && ( params[:apprenticeship][:stripe_card_token] != "" )
          if @apprenticeship.process_payment
            @apprenticeship.paid
            redirect_to payment_confirmation_apprenticeship_path(@apprenticeship) and return
          else
            redirect_to payment_apprenticeship_path(@apprenticeship), :flash => { warning: "There was a problem processing your payment: #{@apprenticeship.errors.full_messages}" } and return
          end
        else
          redirect_to payment_apprenticeship_path(@apprenticeship) and return
        end

        #elsif params[:accept_button]
          #if current_user.admin? && @apprenticeship.accept && @apprenticeship.deliver_accept
            #redirect_to apprenticeships_path, :flash => { :success => "Apprenticeship accepted." } and return
          #end

        #elsif params[:resubmit_button]
          #if @apprenticeship.resubmit && @apprenticeship.deliver_resubmit
            #redirect_to apprenticeships_path, :flash => { :success => "Thanks! Your apprenticeship was resubmitted."} and return
          #end

        #elsif params[:cancel_button]
          #if @apprenticeship.cancel && @apprenticeship.deliver_cancel
            #redirect_to apprenticeships_path, :flash => { :warning => "Rats. Your apprenticeship has been canceled."} and return
          #end
        #end
        raise
      end
    end
  rescue
    error_msg = " "
    @apprenticeship.errors.each do |field, msg|
      error_msg << "<br/>"
      error_msg << msg
    end
    redirect_to :back, :flash => { warning: "Blarf.  The following error(s) occured while attempting to update the apprenticeship: #{error_msg}".html_safe} and return
  end


  def show
    @apprenticeship = Apprenticeship.find(params[:id])
    if current_user && !@apprenticeship.signups.empty?
      @app_signup = @apprenticeship.signups.where(user_id: current_user.id).first
    end
  end

  def new
  end

  def destroy
    @apprenticeship = Apprenticeship.where(:id => params[:id]).first
    if @apprenticeship.verify_delete?
      @apprenticeship.destroy
      redirect_to apprenticeships_path, :flash => { :warning => "Your apprenticeship was deleted."} and return
    else
      redirect_to :back, :flash => { warning: "Your workshop can't be deleted, but you can cancel it if you no longer want it posted." } and return
    end
  end

  def cancel
    @apprenticeship = Apprenticeship.where(:id => params[:id]).first
    @apprenticeship.signups.each {|s| s.cancel && s.deliver_cancel}
    if @apprenticeship.cancel && @apprenticeship.deliver_cancel
      redirect_to apprenticeships_path, :flash => { :warning => "Rats. Your apprenticeship has been canceled."} and return
    else
      raise
    end
  rescue
    error_msg = " "
    @workshop.errors.each do |field, msg|
      error_msg << "<br/>"
      error_msg << msg
    end
    redirect_to :back, :flash => { warning: "Fudge.  The following error(s) occured while attempting to cancel the apprenticeship: #{error_msg}".html_safe} and return
  end

  def accept
    @apprenticeship.accept && @apprenticeship.deliver_accept
    redirect_to apprenticeships_path, :flash => { :success => "Apprenticeship accepted." } and return
  end

  def resubmit
    @apprenticeship.resubmit && @apprenticeship.deliver_resubmit
    redirect_to apprenticeships_path, :flash => { :success => "Thanks! Your apprenticeship was resubmitted. We'll take a look at it and let you know when it's posted."} and return
  end

  #def reject
    #@apprenticeship.reject && @apprenticeship.deliver_reject
    #redirect_to apprenticeships_path, :flash => { :warning => "Apprenticeship rejected." } and return
  #end

  #def revoke
    #@apprenticeship.revoke && @apprenticeship.deliver_revoke
    #redirect_to apprenticeships_path, :flash => { :warning => "Apprenticeship revoked."} and return
  #end

  def private
    unless @apprenticeship.group_valid?(:design)
      redirect_to edit_apprenticeship_path(@apprenticeship), flash: { warning: "Please correct the following: #{@apprenticeship.errors.full_messages}"} and return
    end
  end

  def payment
    unless @apprenticeship.group_valid?(:design)
      redirect_to edit_apprenticeship_path(@apprenticeship), flash: { warning: "Before you pay, please correct the following: #{@apprenticeship.errors.full_messages}"} and return
    end
    unless @apprenticeship.group_valid?(:private)
      redirect_to private_apprenticeship_path(@apprenticeship), :flash => { warning: "Before you pay, please correct the following: #{@apprenticeship.errors.full_messages}" } and return
    end
  end

  def payment_confirmation
  end

  def checkmarks
    respond_to do |format|
      format.json { render json: @apprenticeship.checkmarks }
    end
  end

  def owner_user
      redirect_to apprenticeships_path unless current_user.admin? || current_user==@apprenticeship.user
  end

  def current_apprenticeship
  	@apprenticeship = Apprenticeship.find_by_id(params[:id])
  	redirect_to :index if @apprenticeship.nil?
    @album = @apprenticeship.host_album
  end

  private
    def load_user_gallery
      @user = current_user
      if @user
        @gallery = @user.gallery
      end
    end
end
