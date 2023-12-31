# frozen_string_literal: true

# app/channels/application_cable/connection.rb
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

      def find_verified_user
        verified_user = User.find_by(
          email: request.query_parameters[:email],
          authentication_token: request.query_parameters[:auth_token]
        )
        if verified_user
          verified_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
