module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super do
        if resource.persisted?
          UserMailer.with(user: resource).welcome.deliver_later
        end
      end
    end
  end
end
