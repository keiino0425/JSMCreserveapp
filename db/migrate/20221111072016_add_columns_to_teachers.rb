class AddColumnsToTeachers < ActiveRecord::Migration[6.1]
  def change
    add_column :teachers, :teacher_name, :string, null: false
    add_column :teachers, :teacher_area, :string, null: false
  end
end
