class ApplicationController < ActionController::Base
    helper_method :current_user, :require_login, :search_album
    def current_user
        User.find_by(id: session[:user_id])
    end

    def require_login
        redirect_to login_path, alert: 'Must be Logged in to view this action' if current_user.nil?
    end

    def search_album
        @albums = Album.search_albums(params[:search])
        # add database partial search here
    end 
end
