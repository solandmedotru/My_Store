class Item < ActiveRecord::Base

  validates_numericality_of :price, greater_than: 0
  validates_presence_of :name, :description

end
