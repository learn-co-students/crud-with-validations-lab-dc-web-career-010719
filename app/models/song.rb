class Song < ActiveRecord::Base

  validates :title, presence: true, uniqueness: { scope: :release_year }
  validate :must_have_release_year_when_released_is_true
  validate :release_year_must_be_valid, unless: Proc.new {|a| a.release_year.blank?}

  def release_year_must_be_valid
    if self.release_year > Date.today.year
      errors.add(:release_year, "must be or before #{Date.today.year}")
    end
  end

  def must_have_release_year_when_released_is_true
    if self.released == true
      if !self.release_year
        errors.add(:release_year, "must be entered when released is true")
      end
    end
  end

end
