class RemoveColumnsFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :user_area, :string
    remove_column :users, :curriculum_num, :integer
    remove_column :users, :video_available, :boolean
  end
end
