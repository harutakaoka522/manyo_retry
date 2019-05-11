class RemoveEndLimitFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :end_limit, :interger
  end
end
