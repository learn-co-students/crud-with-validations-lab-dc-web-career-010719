class Song < ActiveRecord::Base
  validates :title, presence: true
  validate :repeat_song, :year, :needs_year

  def repeat_song
    some_song = Song.find_by(title: self.title, artist_name: self.artist_name, release_year: self.release_year)
    if !some_song.nil? && some_song.id != self.id
      errors.add(:title, "Cannot be repeated by the same artist in the same year")
    end
  end

  def year
    if !self.release_year.nil? && self.release_year > Time.now.year
      errors.add(:release_year, "Future release functionality is not yet supported. Please pick a current or past date")
    end
  end

  def needs_year
    if self.released == true && self.release_year.nil?
      errors.add(:release_year, "Cool story bro. When was this made?")
    end
  end

  def released?
    if self.released
      self.release_year
    else
      "Release year pending"
    end
  end

end
