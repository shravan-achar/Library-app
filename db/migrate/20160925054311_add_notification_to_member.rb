class AddNotificationToMember < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :notification, :text
  end
end
