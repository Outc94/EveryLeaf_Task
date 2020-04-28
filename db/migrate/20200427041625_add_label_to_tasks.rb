class AddLabelToTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :label, foreign_key: true
  end
end
