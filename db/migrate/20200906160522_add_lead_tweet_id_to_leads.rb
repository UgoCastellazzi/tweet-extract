class AddLeadTweetIdToLeads < ActiveRecord::Migration[6.0]
  def change
    add_column :leads, :tweet_id, :string
  end
end
