class ProfessionalPractice < ActiveRecord::Base
  belongs_to :company
  has_and_belongs_to_many :majors
  has_one :enrollment
end
