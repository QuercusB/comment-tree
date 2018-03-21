class ThreadCommentsController < ApplicationController
    before_action :load_comment_thread
    before_action :load_comment, only: [:show, :destroy, :create_child]
    
    respond_to :json

    def index
        page = (params[:page] || 0).to_i
        pageSize = (params[:pageSize] || 25).to_i
        respond_with @commentThread.comments_page(page, pageSize)
    end

    def add_comment(container)
        comment = Comment.new(comment_create_params)
        container.comments << comment
        respond_with comment
    end

    def create
        add_comment(@commentThread)
    end

    def create_child
        add_comment(@comment)
    end

    def show
        respond_with @comment
    end
    
    def destroy
        respond_with @comment.destroy
    end

    private 

    def comment_url(comment)
        "threads/#{comment.comment_thread_id}/comments/#{comment.id}"
    end

    def load_comment_thread
        @commentThread = CommentThread.find_by_id(params[:thread_id].to_i)
        head 404 if @commentThread.nil?
    end

    def load_comment
        @comment = Comment.find_by_id(params[:id].to_i)
        head 404 if @comment.nil?
    end

    def comment_create_params
        params.permit(:text, :user_id)
    end

end