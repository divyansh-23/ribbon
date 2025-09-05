class MonitorController < ApplicationController
    # skip_before_action :authenticate_user!
  
    def health
      head :ok
    end
  end