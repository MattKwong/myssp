class ChangeUserRoleField3 < ActiveRecord::Migration
  def self.up
      remove_column :admin_users, :user_role
      add_column :admin_users, :user_role_id, :integer
    end

    def self.down
      remove_column :admin_users, :user_role_id
      add_column :admin_users, :user_role, :string
    end
end
