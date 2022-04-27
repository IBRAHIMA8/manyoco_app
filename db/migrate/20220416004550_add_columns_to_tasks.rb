class AddColumnsToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :deadline, :datetime
    add_column :tasks, :priority, :integer
    add_column :tasks, :status, :integer, default: 0, null: false
  end
end
