# This must be updated for each new controller (TODO: create custom generator that gets run after generate scaffold)
%w(
  diagrams
  institutions
  users
  reports
  devise/sessions
  devise/registrations
  devise/confirmations
  home
).each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.js", "#{controller}.css"]
end
