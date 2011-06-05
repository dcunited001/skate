# FRIENDSHIPS CONTROLLER ================
# TODO: delete friends

class FriendshipsController < ApplicationController
  before_filter :authenticate_member!

  before_filter :get_friendship, :only => [:accept, :deny, :cancel]
  filter_access_to :accept, :reject, :cancel, :attribute_check => true
  filter_access_to :all

  #CANT BE NAMED REQUEST????
  def send_request
    @member = Member.find(params[:id])

    @friendship = Friendship.new 
    @friendship.member = current_member
    @friendship.friend = @member

    @success = @friendship.save

    respond_to do |format|
      format.js
    end
  end

  def accept
    #def get_friendship
    #@friendship = Friendship.find(params[:id])

    @friendship.approved = 1
    @friendship.active = 1
    @friendship.join_date = DateTime.now

    @success = @friendship.save(:validate => false)
    respond_to do |format|
      format.js
    end
  end

  def deny
    #def get_friendship
    #@friendship = Friendship.find(params[:id])

    @friendship.rejected = 1
    @friendship.join_date = DateTime.now

    @success = @friendship.save(:validate => false)
    respond_to do |format|
      format.js
    end
  end

  #params[:id] = member.id
  def delete
    @member = Member.find(params[:id])

    @friendship = Friendship.where(
        'active = 1 and ((member_id = ? and friend_id = ?) or (member_id = ? and friend_id = ?))',
        @member.id, current_member.id, current_member.id, @member.id).first

    #have to search through one by one because this is broken!
    #@friendship = current_member.friendships.of_member(@member).active.first
#    current_member.friendships.each do |f|
#      if ((f.member == @member or f.friend == @member) and f.active)
#          @friendship = f
#          break
#      end
#    end

    @success = false
    if @friendship
      @friendship.active = 0
      @success = @friendship.save(:validate => false)
    end

    respond_to do |format|
      format.js
    end
  end

  def cancel
    #def get_friendship
    #@friendship = Friendship.find(params[:id])

    @friendship.rejected = 1

    @success = @friendship.save(:validate => false)
    respond_to do |format|
      format.js
    end
  end

  def index
    @friends = current_member.friends

    respond_to do |format|
      format.html
    end
  end

  def requests
    @recd_requests = current_member.pending_recd_friend_requests
    @sent_requests = current_member.pending_sent_friend_requests

    respond_to do |format|
      format.html
    end
  end

  protected
  def get_friendship
    @friendship = Friendship.find(params[:id])

    @friendship = Friendship.new if @friendship.nil?
  end
end