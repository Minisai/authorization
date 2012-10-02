Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :developer unless Rails.env.production?
  if Rails.env == "production"
    provider :twitter, 'DIBmvs9tvfoGuVNaiw', '5CAPqBHn76gU6q5dezhWkpL1J8vruSHHwVxBEc33JQ'
  else
    provider :twitter, 'QZeFb9ErUMPjmqgUfIreA', 'q8WFHZBZtFaxx8gbBNmgwrCk5gVgkqpR23SiCmlcks'
  end
end