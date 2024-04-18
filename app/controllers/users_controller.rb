class UsersController < ApplicationController
  def user_page
    @orders = Order.where(user_id: current_user.id)
  end
end
