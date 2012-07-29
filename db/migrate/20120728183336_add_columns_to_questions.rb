class AddColumnsToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :q_type, :string
  end

  def self.down
    remove_column :questions, :q_type
  end
end
