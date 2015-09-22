require 'bcrypt'

class User < ActiveRecord::Base
  validates :password_hash, presence: true
  validate :password_length

  def self.authenticate(user_data)
    user = User.find_by(email: user_data[:email])
    user if user && user.password == user_data[:password]
  end

  def password
    @password ||= BCrypt::Password.new(self.password_hash)
  end

  def password=(value)
    @raw_password = value
    self.password_hash = @password = BCrypt::Password.create(value)
  end

  private

  def password_length
    if @raw_password || new_record?
      unless @raw_password && @raw_password.length >= 6
        errors.add(:password, 'cannot be less than 6 characters')
      end
    end
  end
end

user = User.create(email: "lucas@devbootcamp.com", password: "himegan")
user.email = 'me@ltw.io'
user.save




# BCrypt::Password.create("myfakestring")
# password = BCrypt::Password.new("$2a$10$Z6tgDE7gGTBF49Kskb3/LuqDlYhjnHnu/17CyKMHjmjsdpL1kdrp2")
# password == 'myfakestring'
#
# class BCrypt::Password
#   def self.create(value)
#     new(encrypt(value))
#   end
#
#   def initialize(data)
#     @data = data
#   end
#
#   def ==(value)
#     data == encrypt(value, data)
#   end
#
#   def to_s
#     data
#   end
#
#   private
#   attr_reader :data
#
#   def encrypt(value)
#     if data
#       create_hash_based_off_data(value, data[0..10])
#     else
#       create_totally_new_hash(value)
#     end
#     # $2a$10$Z6tgDE7gGTBF49Kskb3/LuqDlYhjnHnu/17CyKMHjmjsdpL1kdrp2
#   end
# end
