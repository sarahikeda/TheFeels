class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :partner
  has_many :emails
end
