class ChargesController < ApplicationController
  before_action :set_plan, only: :new

  def new
    # respond_to do |format|
    #   format.js
    # end
  end

  def create
   stripe_card_id =
     if params[:credit_card].present?
       CreditCardService.new(@current_user.id, card_params).create_credit_card
     else
       charge_params[:card_id]
     end

   Stripe::Charge.create(
     customer: @current_user.customer_id,
     source:   stripe_card_id,
     amount:   PRICE,
     currency: 'usd'
   )

   if params[:credit_card].present? && stripe_card_id
     current_user.credit_cards.create_with(card_params).find_or_create_by(stripe_id: stripe_card_id)
   end

   rescue Stripe => e
     flash[:error] = e.message
     redirect_to new_charge_path
   end

  def set_plan
    @plan = {
      price: 1000,
    }
  end

  private

  def card_params
    # params.require(:credit_card).permit(:number, :month, :year, :cvc)
    params.permit(:number, :month, :year, :cvc)
  end

  def charge_params
    params.permit(:card_id)
    # params.require(:charge).permit(:card_id)
  end
end
