class WelcomeController < ApplicationController
  def index
    @clients = Client.search(params[:query])
  end

end
