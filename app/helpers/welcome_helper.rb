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
  
  def counter_result
    content_tag :span, :class => "counter-result" do
      "Да: #{@yes_count.to_s}, нет: #{@no_count.to_s}."
    end
  end
end