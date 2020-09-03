class CreateLeads < ActiveRecord::Migration[6.0]
  def change
    create_table :leads do |t|
      t.date :date
      t.string :twitter_account
      t.string :handdle
      t.text :content
      t.integer :retweets_count
      t.integer :comments_count
      t.integer :likes_count
      t.references :alert, null: false, foreign_key: true

      t.timestamps
    end
  end
end