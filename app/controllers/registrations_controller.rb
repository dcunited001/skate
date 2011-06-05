class RegistrationsController < Devise::RegistrationsController

  def create
    # TODO:add the other member properties here
    member = params[:member]

    super
    session[:omniauth] = nil unless @member.new_record?
  end  

  private  
  def build_resource(*args)
    
    super
    if session[:omniauth]
      @member.apply_omniauth(session[:omniauth])
      @member.valid?
    end
  end
end
