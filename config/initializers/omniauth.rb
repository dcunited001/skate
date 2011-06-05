Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '107177539358199', '9bc245bc8ad25b6d54a766416bba457f'
end