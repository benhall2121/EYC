class CreateSurveyResponses < ActiveRecord::Migration
  def self.up
    create_table :survey_responses do |t|
      t.integer :question_id
      t.text :content
      t.integer :survey_id

      t.timestamps
    end
  end

  def self.down
    drop_table :survey_responses
  end
end
