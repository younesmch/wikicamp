class User < ApplicationRecord
  # Include default devise modules. Others available are:
   #db:lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis
end
