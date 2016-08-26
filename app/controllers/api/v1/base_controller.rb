module Api
  module V1
    class BaseController < ApplicationController
      redis = Redis.new

      def index
        render text: "Geoodoom API"
      end

      def upload
      end

      def sign
        @expires = 10.hours.from_now.utc.iso8601

        render json: {
          acl: 'public-read',
          awsaccesskeyid: ENV['AWS_ACCESS_KEY_ID'],
          bucket: 'badcomics',
          expires: @expires,
          key: "uploads/#{params[:name]}",
          policy: policy,
          signature: signature,
          success_action_status: '201',
          'Content-Type' => params[:type],
          'Cache-Control' => 'max-age=630720000, public'
        }, status: :ok
      end

      def signature
        Base64.strict_encode64(
          OpenSSL::HMAC.digest(
            OpenSSL::Digest.new('sha1'),
            ENV['AWS_SECRET_ACCESS_KEY'],
            policy({ secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] })
          )
        )
      end

      def policy(options = {})
        Base64.strict_encode64(
          {
            expiration: @expires,
            conditions: [
              { bucket: 'badcomics' },
              { acl: 'public-read' },
              { expires: @expires },
              { success_action_status: '201' },
              [ 'starts-with', '$key', '' ],
              [ 'starts-with', '$Content-Type', '' ],
              [ 'starts-with', '$Cache-Control', '' ],
              [ 'content-length-range', 0, 524288000 ]
            ]
          }.to_json
        )
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
