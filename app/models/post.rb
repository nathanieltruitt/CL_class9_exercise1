class Post < ApplicationRecord
  has_many :comments
  validates :title, :body, presence: true

  def self.paginate(page)
    limit(10).offset((page.to_i - 1) * 10)
  end
end
