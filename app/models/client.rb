class Client < ActiveRecord::Base
  def self.search(query)
    if query
      find(:all, :conditions => ['full_name LIKE ?', "%#{query}%"], :limit => 1)
    else
      nil
    end
  end

end