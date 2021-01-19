class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_sign_in
  
  private

  def check_sign_in
    unless user_signed_in?
      render json:{status:'sign_in_first'}
      return
    end
  end




end