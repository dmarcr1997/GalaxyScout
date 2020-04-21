class CommentsController < ApplicationController
    before_action :require_login
    def create
        @comment = Comment.create(comment_params)
        if @comment.save
            redirect_to album_path(@comment.album), alert: "comment created at #{@comment.created_time}"
        else
            redirect_to album_path(@comment.album), alert: "error creating comment"
        end
    end

    def destroy
        # raise params.inspect
        @comment = Comment.find_by(:id => params[:id])
        @album = @comment.album
        if @comment.user != current_user 
            redirect_to album_path(@album)
        else
            @comment.destroy
            redirect_to album_path(@album)
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:content, :user_id, :album_id)
    end
    
end
