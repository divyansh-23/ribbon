# lib/warden/strategies/my_custom_strategy.rb
Warden::Strategies.add(:my_custom_strategy) do
    def valid?
      # Conditions to check if this strategy should be applied
      params['username'] && params['password']
    end
  
    def authenticate!
      user = User.find_by(username: params['username'])
      if user && user.authenticate(params['password'])
        success!(user)
      else
        fail!("Could not log in")
      end
    end
  end