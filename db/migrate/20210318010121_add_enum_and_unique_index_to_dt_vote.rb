class AddEnumAndUniqueIndexToDtVote < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
        CREATE TYPE vote_direction AS ENUM ('up', 'down');
    SQL
    add_column :description_track_votes, :vote_dir, :vote_direction
    add_index :description_track_votes, [:desc_track_id, :voter_id], unique: true
  end

  def down
    remove_column :description_track_votes, :vote_dir
    remove_index :description_track_votes, column: [:desc_track_id, :voter_id]
    execute <<-SQL
        DROP TYPE vote_direction;
    SQL
  end
end
