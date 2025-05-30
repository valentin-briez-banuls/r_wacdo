class AddAdminToCollaborateurs < ActiveRecord::Migration[8.0]
  def change
    add_column :collaborateurs, :admin, :boolean
  end
end
