class Staff::Base < ApplicationController
    before_action :staff_login_required

    private def staff_login_required
        raise Forbidden unless current_member.role == 2
    end
end