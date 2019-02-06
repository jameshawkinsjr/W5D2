class PostsController < ApplicationController    
    before_action :require_login
    def new
        @post = Post.new      
    end
    
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        @post.sub_id = params[:sub_id]
        @post.sub_ids = params[:post][:sub_ids]
        if @post.save!
            redirect_to sub_url(params[:sub_id])
        else
            flash.now[:errors] = @post.errors.full_messages
            render :new
        end
    end

    def upvote
        @vote = Vote.new(value: 1, voteable_type: "Post", voteable_id: params[:id])
        @vote.user_id = current_user.id
        @vote.save
        redirect_to post_url(params[:id])
    end
    
    def downvote
        @vote = Vote.new(value: -1, voteable_type: "Post", voteable_id: params[:id])
        @vote.user_id = current_user.id
        @vote.save
        redirect_to post_url(params[:id])
    end
    
    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])
        return unless @post.user_id == current_user.id
        if @post.update_attributes(post_params)
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :edit
        end    
    end
    
    def show
        @post = Post.find(params[:id])
        @all_comments = @post.comments_by_parent_id
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.delete
        redirect_to sub_url(@post.sub_id)
    end

    private
    def post_params
        params.require(:post).permit(:title, :url, :content, sub_ids: [])
    end
end
