require "stripe"

Rails.configuration.stripe = {
  secret_key: Rails.application.credentials.dig(:development, :stripe_secret_key),
  publishable_key: Rails.application.credentials.dig(:development, :stripe_publishable_key)
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
