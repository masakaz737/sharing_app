class Member::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_name

  private

  def require_user_name
    if current_user.name.blank?
      flash[:notice] = "プロフィールの登録をお願いします"
      redirect_to edit_member_user_path(current_user)
    end
  end
end
