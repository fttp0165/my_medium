class User < ApplicationRecord

  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :stories
  #validations
  validates :username, presence: true,uniqueness:true

  #relationships
  has_many :stories
  has_many :follows
  has_one_attached :avatar
  has_many :bookmarks

  #role
  enum role:{
     user: 0,
     vip_user:1,
     platinum_user:2,
     admin:3
}
  #instance method

  def paid_user?
    vip_user? or platinum_user?
  end
  
  def follow?(user)
    follows.exists?(following: user)
  end

  def follow!(user)
    if follow?(user)
      follows.find_by(following: user).destroy
      return 'Follow'
    else
      follows.create(following:user)
      return 'Followed'
    end
  end

  def bookmark?(story)
    bookmarks.exists?(story: story)
  end

  def bookmark!(story)
    if bookmark?(story)
      bookmarks.find_by(story: story).destroy
      return 'UnBookmarked'
    else
      bookmarks.create(story: story)
      return 'Bookmarked'
    end
  end


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name   
      user.image = auth.info.image 
    end
  end
end
