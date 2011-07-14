class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.integer :member_id
      t.references :role
      t.references :rollable, :polymorphic => true
      t.timestamps
    end
  end
  
  def self.down
    drop_table :roles
  end
end

