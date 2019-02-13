class AddLyricsColumnToSongsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :songs, :lyrics, :string
  end
end
