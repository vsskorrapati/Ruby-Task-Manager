class SessionsController < ApplicationController
  skip_before_action :authorize!, only: :create
    def create
        authenticator = UserAuthenticator.new(authentication_params)
        authenticator.perform
    
        render json: authenticator.access_token, status: :created
      end

      def destroy
        current_user.access_token.destroy
      end

      private
    
      def authentication_params
        (request.env['omniauth.auth']).to_h.symbolize_keys
      end

end