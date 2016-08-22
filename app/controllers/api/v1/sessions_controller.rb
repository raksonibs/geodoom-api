module Api
  module V1
    class SessionsController < BaseController
      # http://localhost:3000/auth/steam/callback?response_type=code&client_id=BE84B16B9FDDAC9CEAD6A7CD5915638C&redirect_uri=http%3A%2F%2Flocalhost%3A4200%2Foauth2callback&state=Ymyl7KDyef3ZTNQK&scope=email&approval_prompt=auto&_method=post&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.mode=id_res&openid.op_endpoint=https%3A%2F%2Fsteamcommunity.com%2Fopenid%2Flogin&openid.claimed_id=http%3A%2F%2Fsteamcommunity.com%2Fopenid%2Fid%2F76561198077942014&openid.identity=http%3A%2F%2Fsteamcommunity.com%2Fopenid%2Fid%2F76561198077942014&openid.return_to=http%3A%2F%2Flocalhost%3A3000%2Fauth%2Fsteam%2Fcallback%3Fresponse_type%3Dcode%26client_id%3DBE84B16B9FDDAC9CEAD6A7CD5915638C%26redirect_uri%3Dhttp%253A%252F%252Flocalhost%253A4200%252Foauth2callback%26state%3DYmyl7KDyef3ZTNQK%26scope%3Demail%26approval_prompt%3Dauto%26_method%3Dpost&openid.response_nonce=2016-08-21T16%3A18%3A16Z7%2FUTbPvGJLPEjJotr3emnEwcVpo%3D&openid.assoc_handle=1234567890&openid.signed=signed%2Cop_endpoint%2Cclaimed_id%2Cidentity%2Creturn_to%2Cresponse_nonce%2Cassoc_handle&openid.sig=6r5C8S73uHvSgQ6ZWrpvm3Gh6As%3D
      # after_action :doorkeeper_authorize!, :only => [:auth_callback]
 #       {"response_type"=>"code",
 # "client_id"=>"cat",
 # "redirect_uri"=>"http://localhost:4200/oauth2callback",
 # "state"=>"evZGhZFwZQYo100u",
 # "scope"=>"email",
 # "approval_prompt"=>"auto",
 # "controller"=>"api/v1/sessions",
 # "action"=>"auth_callback"}

      def auth_callback
        auth = request.env['omniauth.auth']
        session[:current_user] = { :nickname => auth.info['nickname'],
                                              :image => auth.info['image'],
                                              :uid => auth.uid }
        
        @user = current_user || User.find_or_create_from_auth_hash(session[:current_user])        
        hash = session[:current_user]
        @user.update_attributes({uid: hash[:uid], nickname: hash[:nickname], image: hash[:image]})
        # application id 1 is steam?
        access_token = Doorkeeper::AccessToken.where(:resource_owner_id => @user.id).first || Doorkeeper::AccessToken.create!(:application_id => 1, :resource_owner_id => @user.id)

        params["redirect_uri"] ||= "http://localhost:4200/oauth2callback"
      
        redirect_to "#{params["redirect_uri"]}?code=200&state=#{params["state"]}&session_token=#{@user.id}&user=#{@user.id}"
        # render json: current_user

        # render text: "<script>window.close();</script>"

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
