class CreateJoinTableRoomsUsers < ActiveRecord::Migration[7.2]
  def change
    create_join_table :rooms, :users do |t|
      # t.index [:room_id, :user_id]
      # t.index [:user_id, :room_id]
    end
    add_index :rooms_users, [:room_id, :user_id], unique: true
  end
end
