class WelcomeController < ApplicationController
  before_filter :authenticate
  
  def index
    @client = Client.search(params[:query])
  end
  
  protected
  
  def authenticate
    authenticate_or_request_with_http_basic "Blacklist" do |username, password|
      username == "admin" && password == "Mavrodi31"
    end
  end

end
