class CommentsController < ApplicationController
    def new
        @comment = Comment.new
    end

    def create
        @comment = Comment.new(comment_params)
        @comment.post_id = params[:post_id]
        @comment.user_id = current_user.id
        @comment.parent_id = params[:parent_id]
        if @comment.save
            redirect_to post_url(params[:post_id])
        else
            flash[:errors] = @comment.errors.full_messages
            render :new
        end
    end

    def upvote
        @vote = Vote.new(value: 1, voteable_type: "Comment", voteable_id: params[:id])
        @vote.user_id = current_user.id
        @vote.save
        redirect_to post_url(params[:post_id])
    end
    
    def downvote
        @vote = Vote.new(value: -1, voteable_type: "Comment", voteable_id: params[:id])
        @vote.user_id = current_user.id
        @vote.save
        redirect_to post_url(params[:post_id])
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to post_url(@comment.post_id)
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end
end