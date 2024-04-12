class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  #belongs_to :province

  validates :password, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_many :orders

  def self.ransackable_attributes(auth_object = nil)
      ["created_at", "id", "id_value", "is_admin", "password", "updated_at", "username"]
  end
end
