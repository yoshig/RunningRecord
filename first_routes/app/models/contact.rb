class Contact < ActiveRecord::Base
  validates :email, :name, :user_id, :presence => true

  belongs_to(:owner,
  :primary_key => :id,
  :foreign_key => :user_id,
  :class_name => "User")

  has_many :contact_shares

  has_many(:shared_users,
    :through => :contact_shares,
    :source => :user
  )

  has_many :favorites

  has_many(
  :favorite_users,
  :through => :favorites,
  :source => :user
  )

  def self.contacts_for_user_id(user_id)
    self.includes(:shared_users).where("contacts.user_id = ? OR contact_shares.user_id = ?", user_id, user_id)
  end

  def self.favorites_for_user_id(user_id)
    self.includes(:favorites).where("favorites.user_id = ? ", user_id)
  end
end
#
# SELECT groups.*
# FROM groups LEFT OUTER JOIN user_group_cmbs
# ON group.id = user_group_cmb.group_id
# where user_group_cmbs.user_id = 1