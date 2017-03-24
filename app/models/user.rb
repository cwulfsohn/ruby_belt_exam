class User < ActiveRecord::Base
  has_secure_password
  has_many :playlists
  has_many :songs
  validates :first_name, :last_name, :email, presence: true
  validates :password, confirmation: true, length: {minimum: 7}, on: :create
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, format: { with: EMAIL_REGEX}, uniqueness: true
end
