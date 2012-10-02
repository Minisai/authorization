class AddPasswordDigestAndRemoveSalt < ActiveRecord::Migration
  def change
    remove_column :users, :salt
    add_column :users, :password_digest, :string
  end
end
