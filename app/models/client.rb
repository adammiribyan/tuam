class Client < ActiveRecord::Base
  def self.search(query)
    if query
      find(:conditions => ['full_name LIKE ?', "%#{query}%"])
    else
      nil
    end
  end

end