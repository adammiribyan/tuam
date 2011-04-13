# encoding: utf-8

module WelcomeHelper
  def answer
    if @client.present?     
      if @client.birth_date.present?
        "— <span class=\"ano\">Да.</span><br />— <span>Дата рождения: #{@client.birth_date}.</span>".html_safe
      else
        "— <span class=\"ano\">Да.</span>".html_safe
      end
    else
      "— <span class=\"ne\">Нет.</span>".html_safe
    end
  end  
end