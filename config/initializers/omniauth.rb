Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :developer unless Rails.env.production?
  provider :twitter, 'QZeFb9ErUMPjmqgUfIreA', 'q8WFHZBZtFaxx8gbBNmgwrCk5gVgkqpR23SiCmlcks'
end