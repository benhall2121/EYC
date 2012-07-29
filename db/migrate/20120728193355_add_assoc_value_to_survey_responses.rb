class AddAssocValueToSurveyResponses < ActiveRecord::Migration
  def self.up
    add_column :survey_responses, :assoc_value, :string
  end

  def self.down
    remove_column :survey_responses, :assoc_value
  end
end
