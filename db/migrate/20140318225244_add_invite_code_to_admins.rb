class AddInviteCodeToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :invite_code, :text
  end
end
