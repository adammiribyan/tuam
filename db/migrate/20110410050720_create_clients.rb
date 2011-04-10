class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :full_name      
    end
  end

  def self.down
    drop_table :clients
  end
end
