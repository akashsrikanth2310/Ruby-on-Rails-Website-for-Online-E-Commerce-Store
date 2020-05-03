class User < ApplicationRecord
  has_one :payment_detail, :dependent => :destroy
  has_many :return_items, :dependent => :destroy
  include OTP::ActiveRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,:omniauthable, :omniauth_providers => [:facebook]

  validates :Name,:email, presence:true
  validates :Name, length: {in: 2..60}



  def is_below_18?
    age = ((Time.zone.now - (self.dob).to_time)/1.year.seconds).floor
    age < 18
  end

  def is_above_65?
    age = ((Time.zone.now - (self.dob).to_time)/1.year.seconds).floor
    age >= 65
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.Name = auth.info.name # assuming the user model has a name

    end
  end
end
