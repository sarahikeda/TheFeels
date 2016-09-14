class User < ActiveRecord::Base
  has_secure_password

  has_many :partners
  has_many :emails
  has_many :relationships

  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
end
