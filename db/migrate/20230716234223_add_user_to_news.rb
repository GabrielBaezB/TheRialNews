class AddUserToNews < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:news, :user_id)
      add_reference :news, :user, null: false, foreign_key: true
    end
  end
end