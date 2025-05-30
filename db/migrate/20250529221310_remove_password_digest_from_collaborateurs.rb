class RemovePasswordDigestFromCollaborateurs < ActiveRecord::Migration[6.1]
  def change
    remove_column :collaborateurs, :password_digest, :string
  end
end
