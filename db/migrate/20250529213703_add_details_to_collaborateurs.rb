class AddDetailsToCollaborateurs < ActiveRecord::Migration[8.0]
  def change
    add_column :collaborateurs, :first_name, :string
    add_column :collaborateurs, :last_name, :string
    add_column :collaborateurs, :hire_date, :date
  end
end
