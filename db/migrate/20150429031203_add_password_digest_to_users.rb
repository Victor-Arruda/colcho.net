class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    add_column :users, :invoke, :string
    add_column :users, :active_record, :string
  end
end
