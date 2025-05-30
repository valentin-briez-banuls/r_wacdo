class AddPasswordDigestToCollaborateurs < ActiveRecord::Migration[8.0]
  def change
    add_column :collaborateurs, :password_digest, :string
  end
end
