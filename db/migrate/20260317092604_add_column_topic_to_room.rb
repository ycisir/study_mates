class AddColumnTopicToRoom < ActiveRecord::Migration[8.1]
  def change
    add_reference :rooms, :topic, null: false, foreign_key: true
  end
end
