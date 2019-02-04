require 'time'

class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :released, inclusion: {in: [true, false]}
  validates :release_year, numericality: {only_integer: true, less_than_or_equal_to: Time.now.year}, allow_nil: true
  validates :artist_name, presence: true

  validate :title_must_be_unique
  validate :release_year_must_be_valid

  def title_must_be_unique
    if self.release_year && !Song.find_by(release_year: self.release_year, artist_name: self.artist_name, title: self.title).nil?
      errors.add(:title, "cannot be repeated by the same artist in the same year")
    end
  end

  def release_year_must_be_valid
    if self.released && self.release_year.nil?
      errors.add(:release_year, "must not be blank if released")
    end
  end
end
