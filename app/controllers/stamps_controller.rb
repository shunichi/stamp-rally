class StampsController < ApplicationController
  before_action :set_user

  def create
    respond_to do |format|
      if stamp = current_user.sent_stamps.create(user: @user)
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
    current_user.post_stamp_destory_to_remotty(stamp)
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end
end
