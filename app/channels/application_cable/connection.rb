module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include Devise::Controllers::Helpers

    identified_by :user

    def connect
      if user_signed_in?
        self.user = current_user
        logger.add_tags 'ActionCable', current_user.email
      end
    end
  end
end
