class Latte < ActiveRecord::Base
  has_many :flavors
  belongs_to :user
end
