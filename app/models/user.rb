class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :province

  validates :email, :password, :is_admin, presence: true
  validates :email, uniqueness: true
  validates :is_admin, inclusion: [true, false]

  has_many :orders

  def self.ransackable_attributes(auth_object = nil)
      ["created_at", "id", "id_value", "is_admin", "password", "updated_at", "username"]
  end
end
