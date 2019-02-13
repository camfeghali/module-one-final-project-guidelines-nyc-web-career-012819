
class LyricsAPI
  attr_accessor :song, :artist

  def initialize(song, artist)
    @song = song
    @artist = artist
  end

  def song_url
    @song.strip.gsub(" ", "%20")
  end

  def artist_url
    @artist.strip.gsub(" ", "%20")
  end

  def get_lyrics
    url = "https://private-anon-5fa207b84f-lyricsovh.apiary-proxy.com/v1/"
    full_url = "#{url}#{artist_url}/#{song_url}"
    response = RestClient.get(full_url)
    JSON.parse(response)["lyrics"]
  end
end
