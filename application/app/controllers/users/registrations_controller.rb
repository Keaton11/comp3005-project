class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |user|
      if user.persisted?
        role = params[:role_type].constantize.create!
        user.roleable = role
        user.save
      end
    end
  end
end
