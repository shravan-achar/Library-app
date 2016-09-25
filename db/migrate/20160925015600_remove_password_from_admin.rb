class RemovePasswordFromAdmin < ActiveRecord::Migration[5.0]
  def change
    remove_column :admins, :password, :string
  end
end
