class User <  ActiveRecord::Base
  validates :username, :uniqueness => true, :presence => true

  has_many(:contacts,
  :primary_key => :id,
  :foreign_key => :user_id,
  :class_name => "Contact")

  has_many :contact_shares

  has_many(:shared_contacts,
    :through => :contact_shares,
    :source => :contact
  )

  has_many :favorites

  has_many(
  :favorite_contacts,
  :through => :favorites,
  :source => :contact
  )



end
