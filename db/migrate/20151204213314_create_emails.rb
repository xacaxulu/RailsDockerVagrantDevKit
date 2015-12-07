class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.text :address

      t.timestamps null: false
    end
  end
end
