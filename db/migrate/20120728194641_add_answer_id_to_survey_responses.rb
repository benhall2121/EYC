class AddAnswerIdToSurveyResponses < ActiveRecord::Migration
  def self.up
    add_column :survey_responses, :answer_id, :integer
  end

  def self.down
    remove_column :survey_responses, :answer_id
  end
end
