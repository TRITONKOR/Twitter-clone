class RelationshipsController < ApplicationController
    before_action :require_login

    def create
        current_user.active_relationships.create(followed_id: params[:followed_id])
        redirect_back fallback_location: root_path
    end

    def destroy
        relationship = current_user.active_relationships.find_by(followed_id: params[:id])
        relationship&.destroy
        redirect_back fallback_location: root_path
    end
end
