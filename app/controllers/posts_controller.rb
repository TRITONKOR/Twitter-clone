class PostsController < ApplicationController
    before_action :require_login

    def index
        @posts = Post.where(user_id: current_user_and_following_ids)
                     .order(created_at: :desc)
    end

    def new
        @post = Post.new
    end

    def create
        @post = current_user.posts.build(post_params)

        if @post.save
            redirect_to posts_path, notice: "Post created successfully."
        else
            flash.now[:alert] = "Failed to create post."
            render :new
        end
    end

    private

    def post_params
        params.require(:post).permit(:content)
    end

    def current_user_and_following_ids
        following_ids = Relationship.where(follower_id: current_user.id).pluck(:followed_id)
        following_ids << current_user.id
        following_ids
    end
end
