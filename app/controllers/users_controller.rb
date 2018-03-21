class UsersController < ApplicationController
    respond_to :json

    before_action :load_user, only: [:show, :destroy]

    def index
        respond_with User.all
    end

    def create
        respond_with User.create(user_params)
    end

    def show
        respond_with @user
    end
    
    def destroy
        respond_with @user.destroy
    end

    private

    def user_params
        params.permit(:name)
    end

    def user_url(user)
        "/users/#{user.id}"
    end

    def load_user
        @user = User.find_by_id(params[:id])
        head 404 if @user.nil?
    end

end