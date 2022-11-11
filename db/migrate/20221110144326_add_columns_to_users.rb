class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_name, :string, null: false
    add_column :users, :user_area, :string, null: false
    add_column :users, :curriculum, :string, null: false
    add_column :users, :curriculum_num, :integer, default: 1, null: false
    add_column :users, :video_available, :boolean, default: true, null: false
  end
end
