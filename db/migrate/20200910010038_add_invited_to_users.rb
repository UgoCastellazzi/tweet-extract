class AddInvitedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :invited, :boolean
  end
end
