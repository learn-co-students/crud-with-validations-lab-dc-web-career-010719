class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :released, inclusion: { in: [true, false], message: "Can only be true or false"}
  validates :release_year, presence: true, if: :released?
  validates :artist_name, presence: true
  validate :current_year_or_less?
  validates_uniqueness_of :release_year, scope: [:title, :artist_name]

  def released?
    released == true
  end

  def current_year_or_less?
    if release_year.present? && release_year > Time.now.year
      errors.add(:release_year, "Song cannot be released ahead of current year")
    end
  end
end
