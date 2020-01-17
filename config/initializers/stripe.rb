require "stripe"

Rails.configuration.stripe = {
  secret_key: Rails.application.credentials.dig(:development, :stripe_secret_key),
  publishable_key: Rails.application.credentials.dig(:development, :stripe_publishable_key)
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

# Stripe::Charge.list()
#
# StripeEvent.configure do |events|
#   events.subscribe 'charge.succeeded' do |event|
#     # Here you can send notification to user,
#     # change transaction state or whatever you want.
#   end
# end
# retrieve single charge
# Stripe::Charge.retrieve(
#   "ch_18atAXCdGbJFKhCuBAa4532Z",
# )
