class AddPasswordDigestToAdmin < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :password_digest, :string
  end
end
