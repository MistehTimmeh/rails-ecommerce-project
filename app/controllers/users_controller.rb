class UsersController < ApplicationController
  def sign_up

  end

  def login

  end
  def user_page
    @orders = Order.where(user_id: current_user.id)

  end
end
