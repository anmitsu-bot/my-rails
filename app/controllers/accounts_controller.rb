class AccountsController < ApplicationController
  before_action :login_required , except: [:new, :create]
  def show
    @member = current_member
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    @member.assign_attributes(params[:account])

    unless @member.valid?
      @member.errors.full_messages.each do |msg|
        @member.errors.add(:member, msg)
      end
      render :edit
      return
    end
    if @member.save
      redirect_to :account, notice: "アカウント情報を更新しました。"
    else
      render "edit"
    end
  end
  def create
    @member = Member.new(params[:account])
    if @member.save
      redirect_to :root, notice: "会員を登録しました。"
    else
      render "new"
    end
  end
  def new
    @member = Member.new
  end 
end
