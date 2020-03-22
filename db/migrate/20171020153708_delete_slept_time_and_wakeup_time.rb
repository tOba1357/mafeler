class DeleteSleptTimeAndWakeupTime < ActiveRecord::Migration[5.1]
  def change
    remove_column :diaries, :slept_time, :integer
    remove_column :diaries, :wakeup_time, :integer
  end
end
