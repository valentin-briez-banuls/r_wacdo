class AddCanAccessToCollaborateurs < ActiveRecord::Migration[8.0]
  def change
    add_column :collaborateurs, :can_access, :boolean
  end
end
