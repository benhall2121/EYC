class CreateScoreAnswers < ActiveRecord::Migration
  def self.up
    create_table :score_answers do |t|
      t.integer :survey_id
      t.string :content

      t.timestamps
    end
  end

  def self.down
    drop_table :score_answers
  end
end
