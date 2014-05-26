class User < ActiveRecord::Base;
  has_many :posts
  has_many :comments
  has_many :votes
  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, length: {minimum:3}, presence: true, on: :create #this mean the validation will only fire up on create action
  before_save :generate_slug!



  def to_slug(name)
    "#{name.strip.downcase.gsub(/\s*[^A-Za-z0-9]\s*/,'-').gsub(/-+/,'-')
}"
  end

  def generate_slug!
    self.slug = to_slug(self.username)
  end

  def to_param
    self.slug
  end

end