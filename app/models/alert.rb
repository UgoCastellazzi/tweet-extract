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
end
