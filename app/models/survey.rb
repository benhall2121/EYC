class Survey < ActiveRecord::Base
  belongs_to :company
  has_many :questions, :dependent => :destroy
  has_many :survey_responses, :dependent => :destroy
  has_many :score_answers, :dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :score_answers, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :survey_responses, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
end
