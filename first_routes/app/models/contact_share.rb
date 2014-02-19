class ContactShare < ActiveRecord::Base
  validates :contact_id, :user_id, :presence => true

  belongs_to :user
  belongs_to :contact
end
