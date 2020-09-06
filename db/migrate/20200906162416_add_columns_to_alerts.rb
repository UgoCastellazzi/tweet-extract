class AddColumnsToAlerts < ActiveRecord::Migration[6.0]
  def change
    add_column :alerts, :exact_keyword, :boolean
    add_column :alerts, :keywords_excluded, :string
    add_column :alerts, :hashtags, :string
    add_column :alerts, :language, :string
    add_column :alerts, :mentionned_accounts, :string
    add_column :alerts, :answers_included, :boolean
    add_column :alerts, :answers_only, :boolean
    add_column :alerts, :retweets_included, :boolean
    add_column :alerts, :retweets_only, :boolean
    add_column :alerts, :begin_date, :date
    add_column :alerts, :end_date, :date
  end
end
