class Latte < ActiveRecord::Base
  has_many :flavors
  belongs_to :user

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end
