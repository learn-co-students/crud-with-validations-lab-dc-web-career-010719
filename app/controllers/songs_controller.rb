class SongsController < ApplicationController
  before_action :song_by_id, only: [:edit, :show, :update, :destroy]

  def index
    @songs = Song.all
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
  end

  def update

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @song.destroy
    redirect_to songs_path
  end

  private

  def song_params
    # <notes> params.require(:song).permit(:title, :artist_name, :genre_id, note_contents: [])
    # <notes> params.require(:care_taker).permit(:name, :age, :job, kids_attributes: [:name, :age, :hobby, :adult])
    params.require(:song).permit(:title, :released, :release_year, :artist_name, :genre)
  end

  def song_by_id
    @song = Song.find(params[:id])
  end

end
