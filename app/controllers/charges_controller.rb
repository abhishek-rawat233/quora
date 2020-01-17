class ChargesController < ApplicationController
  before_action :set_offer

  def new
  end

  def create
    @amount = @offer[:price].to_i * 100
    # Amount in cents
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'credit plan',
      currency: 'usd',
    })

    if charge[:paid]
      @current_user.increment(:credits, @offer[:credits])
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
    rescue Stripe::InvalidRequestError => e
      flash[:error] = e.message
      redirect_to user_credits_path
  end

  def set_offer
    @offer = OFFERS[params[:offer].to_sym].merge(offer:params[:offer])
  end
end
