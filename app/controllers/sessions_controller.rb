class SessionsController < ApplicationController
  def create
    member = Member.find_by(name: params[:name])

    if member&.authenticate(params[:password])
      session[:member_id] = member.id
      redirect_to after_login_path(member)
    else
      flash.alert = "名前とパスワードが一致しません"
      redirect_to :login
    end
  end

  def destroy
    session.delete(:member_id)
    session[:cart] = {}
    redirect_to :root
  end

  private

  def after_login_path(member)
    case member.role
    when 3
      :admin_root
    when 2
      :staff_root
    else
      :root
    end
  end
end