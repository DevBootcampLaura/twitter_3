class Tweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :user
      t.string :status
      t.timestamps
    end

    add_index :tweets, :user_id
  end
end
