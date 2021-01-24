class UsersController < ApplicationController
  def pricing
  end

  def payment
    @fee=ENV["price_#{params[:type]}"]
    @payment_type=(params[:type] == 'vip') ? 'VIP會員' : '白金會員'
    @token= gateway.client_token.generate
  end

  def pay

    fee=ENV["price_#{params[:type]}"]
    nonce=params[:payment_method_nonce]
    payment_device_data=params[:payment_device_data]
    result = gateway.transaction.sale(
      amount: fee,
      payment_method_nonce: nonce,
      device_data: payment_device_data,
      options: {
        submit_for_settlement: true
      }
    )

    if result.success?
      current_user.send("#{params[:type]}_user!")  
      redirect_to root_path ,notice:'恭喜您成為會員'
    else
      redirect_to root_path ,notice:'付費發生錯誤'
    end
  end

  private
  def gateway 
    Braintree::Gateway.new(
    environment:  :sandbox,
    merchant_id:  ENV['braintree_merchant_id'],
    public_key:   ENV['braintree_public_key'],
    private_key:  ENV['braintree_private_key'],
    )
  end

end
