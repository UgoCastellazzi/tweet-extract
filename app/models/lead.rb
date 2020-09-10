class Lead < ApplicationRecord
  belongs_to :alert

  def self.to_csv
    attributes = %w(handdle twitter_display_name tweet_content description followers profile_pic_url tweet_id)
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |lead|
        csv << lead.attributes.values_at(*attributes)
      end
    end

  end

end
