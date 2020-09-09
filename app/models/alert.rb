class Alert < ApplicationRecord
  belongs_to :user
  has_many :leads, dependent: :destroy

  def array_from_keywords_excluded
    self.keywords_excluded.split(',')
  end

  def array_from_hashtags
    self.hashtags.split(',')
  end

  def array_from_mentionned_accounts
    self.mentionned_accounts.split(',')
  end

  def keyword_creation
    if self.exact_keyword
      '"' + "#{self.keyword}" + '"'
    else
      "#{self.keyword}"
    end
  end

  def excluded_keywords_creation
    result = ""
    self.array_from_keywords_excluded.each do | keyword |
      result += "-#{keyword.strip} "
    end
    result.strip
  end

  def hashtags_creation
    result = ""
    self.array_from_hashtags.each do | hashtag |
      result += "#{hashtag.strip} "
    end
    result.strip
  end

  def retweets_creation
    if self.retweets_included
      ""
    else
      "-rt -RT"
    end
  end

  def compute_search
    "#{self.keyword_creation} #{self.excluded_keywords_creation} #{self.hashtags_creation} #{self.retweets_creation}"
  end
end
