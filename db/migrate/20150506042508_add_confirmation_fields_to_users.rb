class AddConfirmationFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmado_em, :datetime
    add_column :users, :codigo_confirmacao, :string
  end
end
