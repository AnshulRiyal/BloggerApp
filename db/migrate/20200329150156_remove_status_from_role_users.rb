class RemoveStatusFromRoleUsers < ActiveRecord::Migration[6.0]
  def change

    remove_column :role_users, :status, :string
  end
end
