class CreateContactForms < ActiveRecord::Migration
  def self.up
    create_table :contact_forms do |t|
      t.string :name
      t.string :email
      t.text :message
    end
  end

  def self.down
    drop_table :contact_forms
  end
end
