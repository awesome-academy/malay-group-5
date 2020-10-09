class Course < ApplicationRecord
  validates :name, presence: true,
    length: {maximum: Settings.validate.course_name.max_length},
    uniqueness: true
end
