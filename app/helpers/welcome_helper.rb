# encoding: utf-8

module WelcomeHelper
  def answer
    if @client.present?
      "Да"
    else
      "Нет"
    end
  end
  
end
