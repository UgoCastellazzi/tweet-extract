class CreateLeads < ActiveRecord::Migration[6.0]
  def change
    create_table :leads do |t|
      t.date :date
      t.string :twitter_display_name
      t.string :handdle
      t.text :tweet_content
      t.text :description
      t.integer :followers
      t.integer :following
      t.string :profile_pic_url
      t.references :alert, null: false, foreign_key: true

      t.timestamps
    end
  end
end