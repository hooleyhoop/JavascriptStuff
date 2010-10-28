class CreateElephants < ActiveRecord::Migration
  def self.up
    create_table :elephants do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :elephants
  end
end
