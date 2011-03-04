class CreateForms < ActiveRecord::Migration
  def self.up
    create_table :forms do |t|
      t.string :custom_subject
      t.string :email_to
      t.string :token
    end
  end

  def self.down
    drop_table :forms
  end
end
