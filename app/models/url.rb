class Url < ActiveRecord::Base
  belongs_to :user
  validates :long_url, :presence => true
  validates :short_url, :uniqueness => true
  validate  :must_be_a_url, on: :save

  def must_be_a_url
    if url_valid?
      return self
    else
      errors.add(:base, "url is not valid")
    end
  end

  def url_valid?
    if self.long_url.match(/https?:\/\/.+/) == nil
      return false
    else 
      return true
    end
  end

  def self.shorten
    (0...8).map{(65+rand(26)).chr}.join
  end

  def self.nil_urls

    nil_urls = []
    self.all.each do |url_datum|
      if url_datum.user_id == nil
        nil_urls << url_datum
      end
    end
    return nil_urls
  end
end
