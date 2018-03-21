class ThreadsController < ApplicationController
    respond_to :json

    before_action :load_comment_thread, only: [:show, :destroy]

    def index
        respond_with CommentThread.all
    end

    def create
        respond_with CommentThread.create
    end

    def show
        respond_with @commentThread
    end
    
    def destroy
        respond_with @commentThread.destroy
    end

    private

    def comment_thread_url(comment_thread)
        "/threads/#{comment_thread.id}"
    end

    def load_comment_thread
        @commentThread = CommentThread.find_by_id(params[:id])
        head 404 if @commentThread.nil?
    end

end