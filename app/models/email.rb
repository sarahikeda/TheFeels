class Email < ActiveRecord::Base
  belongs_to :user
  belongs_to :partner
  belongs_to :relationship
end
