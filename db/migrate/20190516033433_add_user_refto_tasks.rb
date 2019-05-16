class AddUserReftoTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :user, foreign_key: true
  end
end


#rails g migration AddAuthorRefToBooks author:references
#rails g migration AddUserReftoTasks user:references
