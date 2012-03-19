class AddFriendsObjects < ActiveRecord::Migration
  def up
    ski = Skiima.new(Rails.env.to_sym)
    ski.up(:friends)
    # Skiima.up(Rails.env.to_sym, :friends)
  end

  def down
    ski = Skiima.new(Rails.env.to_sym)
    ski.down(:friends)
    # Skiima.up(Rails.env.to_sym, :friends)
  end
end
