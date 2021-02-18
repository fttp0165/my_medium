class Story < ApplicationRecord

  extend FriendlyId
  friendly_id :slug_candidate, use: :slugged

  acts_as_paranoid

  include AASM

  #BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
  #vaild
  #BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
  validates :title, presence: true
  #BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
  #slug about personal picture resize
  #BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB

  def slug_candidate
    [
      :title,
      [:title,SecureRandom.hex[0,8]]
    ]
  end
  
  #BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
  #modify path show id
  #BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
 
  #BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
  #relationships
  #BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB

  belongs_to :user
  has_one_attached :cover_image
  has_many :comments
  has_many :bookmarks

 
  #BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
  #scope about soft delete
  #BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB

  default_scope{where(deleted_at:nil)}
  
  scope :published_stories,->{published.with_attached_cover_image.order(created_at: :desc).includes(:user)}


  #BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
  #instance method
  #BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB

  # def destroy
  #   update(deleted_at: Time.now)
  # end

  #BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
  #status machine change article status 
  #文章狀態機使用 gem-aasm
  #BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB 
  aasm(column: 'status',no_direct_assignment: true) do
    state :draft, initial: true
    state :published
     
    event :publish do
      transitions from: :draft, to: :published
    end
    event :unpublish do
      transitions from: :published, to: :draft
    end
  end

  private

 

end
