class WelcomeController < ApplicationController
  def index
    @client = Client.search(params[:query])
  end

end
