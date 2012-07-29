class AddColumnsToScoreAnswer < ActiveRecord::Migration
  def self.up
    add_column :score_answers, :start_range, :integer
    add_column :score_answers, :end_range, :integer
  end

  def self.down
    remove_column :score_answers, :end_range
    remove_column :score_answers, :start_range
  end
end
