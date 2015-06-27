class StampsController < ApplicationController
  before_action :master_user
  before_action :set_user

  def create
    stamp = current_user.sent_stamps.build(user: @user)
    respond_to do |format|
      if stamp.save
        current_user.post_stamp_creation_to_remotty(stamp)
        format.js { render }
      else
        format.js { render :failed }
      end
    end
  end

  def destroy
    stamp = current_user.sent_stamps.find_by!(user: @user)
    stamp.destroy
    current_user.post_stamp_destruction_to_remotty(stamp)
  end

  private
  def master_user
    head :forbidden unless current_user.master?
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
