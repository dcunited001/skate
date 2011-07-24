class LoggedInConstraint < Struct.new(:value)
  #this class is used as a constraint in the routes
  #  to help determine if the user is logged in

  #if they are logged in, they will be sent to HomeController
  #otherwise they will be routed to the GuestController

  #devise authentication will take effect as well

  def matches?(request)
    request.cookies.key?("user_token") == value
  end
end

#looks like i won't need this but it's a pretty cool technique anyway