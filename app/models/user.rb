class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %i[admin]

  scope :admin, -> { where(role: "admin") }

  has_and_belongs_to_many :platforms

  def platforms
    if role == "admin"
      Platform.all
    else
      super
    end
  end

  def to_s
  	email
  end

end
