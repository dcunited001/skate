
class AuthenticationsController < ApplicationController
  def index
    @authentications = current_member.authentications if current_member
  end


  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:member, authentication.member)
    elsif current_member
      current_member.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      member = Member.new
      member.apply_omniauth(omniauth)
      if member.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:member, member)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_member_registration_url
      end
    end
  end


  def destroy
    @authentication = current_member.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end

=begin
YAML Response to login
---
user_info:
  name: David Conner
  urls:
    Facebook: http://www.facebook.com/dconner.pro
    Website:
  nickname: dconner.pro
  last_name: Conner
  first_name: David
  uid: "1732883075"
  credentials:
    token: 107177539358199|8264a8e5dba596a789f17684-1732883075|6cR3VdUJV73XQno5r6Sk7php-VA
  extra:
    user_hash:
      name: David Conner
      timezone: -5
        gender:
          male id: "1732883075"
      last_name: Conner
      updated_time: 2011-01-12T23:57:42+0000
      verified: true
      locale: en_US
      link: http://www.facebook.com/dconner.pro 
      email: dconner.pro@gmail.com
      first_name: David
      provider: facebook
=end