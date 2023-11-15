class AddVoteTypeToVotes < ActiveRecord::Migration[7.1]
  def change
    add_column :votes, :vote_type, :integer
  end
end
