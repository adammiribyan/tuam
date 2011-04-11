# encoding: utf-8

module WelcomeHelper
  def answer
    if @client.present?
      "— <span class=\"ano\">Да.</span>".html_safe
    else
      "— <span class=\"ne\">Нет.</span>".html_safe
    end
  end
  
end
