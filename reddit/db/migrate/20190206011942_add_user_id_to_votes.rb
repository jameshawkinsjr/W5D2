class AddUserIdToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :user_id, :integer
    add_index :votes, [:user_id, :voteable_id, :voteable_type], unique: true 
  end
end
