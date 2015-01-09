# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController

  def create
    params['user']['ip_address'] = request.env['REMOTE_ADDR']
    super
  end

end