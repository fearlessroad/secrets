class User < ActiveRecord::Base
  has_secure_password
  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many  :secrets_liked, through: :likes, source: :secret
  EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :name, :email, :password, presence:true
  validates :email, uniqueness: {case_sensitive: false}, format: {with: EMAIL_REGEX}
end
