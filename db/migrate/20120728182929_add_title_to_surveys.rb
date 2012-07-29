class AddTitleToSurveys < ActiveRecord::Migration
  def self.up
    add_column :surveys, :title, :string
  end

  def self.down
    remove_column :surveys, :title
  end
end
