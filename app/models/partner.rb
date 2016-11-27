class Partner < ActiveRecord::Base
  belongs_to :user
  has_many :emails
  has_many :relationships

  validates_uniqueness_of :email
end
