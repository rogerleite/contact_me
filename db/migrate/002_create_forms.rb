class CreateForms < ActiveRecord::Migration
  def self.up
    create_table :forms do |t|
      t.string :subject
      t.string :email_to
      t.string :token
      t.integer :account_id, :nullable => false
      t.timestamps
    end
  end

  def self.down
    drop_table :forms
  end
end
