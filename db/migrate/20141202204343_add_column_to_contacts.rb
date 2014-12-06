class AddColumnToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :content, :text
  end
end
