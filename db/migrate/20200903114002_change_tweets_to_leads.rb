class ChangeTweetsToLeads < ActiveRecord::Migration[6.0]
  def change
    rename_table :tweets, :leads
  end
end
