class SongsController < ApplicationController
  def index
    @songs = Song.all.order(created_at: :desc)
  end

  def show
    @song = Song.find(params[:id])
    @playlist_user = Playlist.where(song_id: params[:id])
  end

  def create
    song = Song.create(title: params[:title], artist: params[:artist], user: User.find(session[:id]))
    if song.valid?
      redirect_to '/songs'
    else
      flash[:errors] = song.errors.full_messages
      redirect_to '/songs'
    end
  end

  def playlist
    playlist = Playlist.create(song: Song.find(params[:id]), user: User.find(session[:id]))
    if playlist.valid?
      redirect_to '/songs'
    else
      redirect_to '/songs', alert: "Song did not get added to the playlist"
    end
  end

  def change
    redirect_to '/songs'
  end
end
