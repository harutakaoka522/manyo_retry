class AddEndLimitToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :end_limit, :date
  end
end
