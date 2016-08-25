module Api
  module V1
    class BaseController < ApplicationController
      redis = Redis.new

      def index
        render text: "Geoodoom API"
      end

      private
      def current_user(session = nil)
        @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
        @current_user ||= User.find_by_uid(session[:current_user][:uid]) if session && session[:current_user]
        @current_user ||= User.find(Doorkeeper::AccessToken.last.try(:resource_owner_id)) if Doorkeeper::AccessToken.last.try(:resource_owner_id) && Rails.env.development?        
        # doorkeeper, torri, ember simple auth all playing wrongly together
        @current_user.update_attributes(online: true) unless @current_user.nil?
        @current_user
      end

      def current_pet
        @current_pet ||= Pet.find(params[:pet_id]) if params[:pet_id]
        @current_pet ||= current_user.pets.last if Rails.env.development?
      end
    end
  end
end
