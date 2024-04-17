#Rails.configuration.strip = {
#    publishable_key: ENV["PUBLISHABLE_KEY"],
#    secret_key: ENV["SECRET_KEY"]
#}
#Stripe.api_key = Rails.configuration.strip[:secret_key]

Rails.application.credentials.dig(:stripe, :publishable_key)
Rails.application.credentials.dig(:stripe, :secret_key)

Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)