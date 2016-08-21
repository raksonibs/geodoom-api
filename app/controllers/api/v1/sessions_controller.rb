module Api
  module V1
    class SessionsController < ApplicationController
      def auth_callback
        auth = request.env['omniauth.auth']
        session[:current_user] = { :nickname => auth.info['nickname'],
                                              :image => auth.info['image'],
                                              :uid => auth.uid }
        redirect_to root_url
      end

      def create
        @user = User.find_or_create_from_auth_hash(auth_hash)
        self.current_user = @user
      end

      protected

      def auth_hash
        request.env['omniauth.auth']
      end
    end
  end
end
