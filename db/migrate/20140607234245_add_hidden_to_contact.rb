class AddHiddenToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :hidden, :boolean
  end
end
