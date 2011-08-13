#this migration should probably execute last

class CreateSqlLoaderObjects < ActiveRecord::Migration
  def self.up
    SqlLoader::SqlLoaderBase.create_all
  end

  def self.down
    SqlLoader::SqlLoaderBase.drop_all
  end
end