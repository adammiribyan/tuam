class Client < ActiveRecord::Base
  def self.search(query)
    if query
      find(:all, :conditions => ['full_name LIKE ?', "%#{query}%"]).first
    else
      nil
    end
  end

end