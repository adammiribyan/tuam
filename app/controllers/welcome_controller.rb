class WelcomeController < ApplicationController
  before_filter :authenticate
  
  def index
    @client = Client.search(params[:query])    
    
    if @client.present?
      Counter.create!(:yes => true)
    else
      Counter.create!(:no => true)
    end
    
    @yes_count  = Counter.where(:yes => true).count
    @no_count   = Counter.where(:no => true).count
  end
  
  protected
  
  def authenticate
    authenticate_or_request_with_http_basic "Blacklist" do |username, password|
      username == "admin" && password == "Mavrodi31"
    end
  end

end
