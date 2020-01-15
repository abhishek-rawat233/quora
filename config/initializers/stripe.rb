Rails.configuration.stripe = {
  stripe_secret_key: Rails.application.credentials.dig(:development, :stripe_secret_key),
  stripe_publishable_key: Rails.application.credentials.dig(:development, :stripe_publishable_key)
}

Stripe.api_key = Rails.application.credentials.dig(:development, :stripe_secret_key)
