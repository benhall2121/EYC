class SurveyResponse < ActiveRecord::Base
  belongs_to :question
  belongs_to :survey
  belongs_to :answer
end
