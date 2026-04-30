class MessagesController < ApplicationController
    before_action :require_login

    def index
        @users = User.where.not(id: current_user.id)
        @messages = Message.where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)",
        current_user.id, params[:user_id],
        params[:user_id], current_user.id).order(created_at: :desc)
    end

    def create
        Message.create!(
            sender_id: current_user.id,
            receiver_id: params[:receiver_id],
            content: params[:content]
        )

        redirect_back fallback_location: root_path
    end

    def inbox
        @messages = Message.where(receiver_id: current_user.id)
                            .includes(:sender)
                            .order(created_at: :desc)
    end
end
