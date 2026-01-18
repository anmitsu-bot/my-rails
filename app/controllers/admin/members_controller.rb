class Admin::MembersController < Admin::Base
    def index
        @member = Member.all
    end
    def show
        @member = Member.find(params[:id])
    end
    def new
        @member = Member.new(role: 2 )
    end
    def create
        @member = Member.new(params[:member])
        @member.point = 0
        if @member.save
            redirect_to [:admin, @member], notice: "会員を登録しました。"
        else
            render "new"
        end
    end
    def edit
        @member = Member.find(params[:id])
    end
    def update
        @member = Member.find(params[:id])
        @member.assign_attributes(params[:member])
        if @member.save
            redirect_to [:admin, @member], notice: "会員情報を更新しました。"
        else
            render "edit"
        end
    end
    def passedit
        @member = Member.find(params[:id])
    end
    def p_update
        @member = Member.find(params[:id])
        current_password = params[:member][:current_password]
        if current_password.present?
            if @member.authenticate(current_password)
                @member.assign_attributes(password: params[:member][:password])
                if @member.save(context: :password_update)
                    redirect_to [:admin, @member], notice: "パスワードを変更しました。"
                else
                    render "passedit"
                end
            else
                @member.errors.add(:current_password, :wrong)
                render "passedit"
            end
        else
            @member.errors.add(:current_password, :empty)
            render "passedit"
        end
    end
    def destroy
        @member = Member.find(params[:id])
        @member.destroy
        redirect_to :admin_members, notice: "会員を削除しました。"
    end

end
