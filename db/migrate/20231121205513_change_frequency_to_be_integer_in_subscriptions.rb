class ChangeFrequencyToBeIntegerInSubscriptions < ActiveRecord::Migration[7.0]
  def change
    change_column :subscriptions, :frequency, :integer, using: 'frequency::integer'
  end
end
