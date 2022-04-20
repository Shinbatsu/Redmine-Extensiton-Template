class CreateVotes < ActiveRecord::Migration
  def self.up

    create_table :voting_votes do |t|
      t.column :project_id, :integer, :null => false
      t.column :question, :string, :null =>false
      t.column :created_on, :timestamp, :null =>false
      t.column :revote, :boolean
    end

    add_index :voting_votes, [:project_id], :name => :votes_project_id

    create_table :voting_choices do |t|
      t.column :vote_id, :integer, :null => false
      t.column :text, :string, :null => false
      t.column :created_on, :timestamp, :null => false
      t.column :position, :integer, :default => 1
    end

    add_index :voting_choices, [:vote_id], :name => :choices_vote_id

    create_table :voting_votes do |t|
      t.column :user_id, :integer, :null =>false
      t.column :vote_id, :integer, :null =>false
      t.column :choice_id, :integer, :null =>false
      t.column :created_on, :timestamp, :null => false
    end

    add_index :voting_votes, [:user_id], :name => :votes_user_id
    add_index :voting_votes, [:vote_id], :name => :votes_vote_id
    add_index :voting_votes, [:choice_id], :name => :votes_choice_id
    add_index :voting_votes, [:user_id,:vote_id], :unique => true, :name => :votes_user_vote_unique

  end


  def self.down
    drop_table :voting_votes
    drop_table :voting_choices
    drop_table :voting_votes
  end
end
