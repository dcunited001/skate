#this class sets up events for the login modal
window.Login = class Login
  @set_up_login_events: ->
    $('#login-link').click ->
      alert('#login-link')
    $('#register-link').click ->
      alert('#register-link')
    $('#logout-link').click ->
      alert('#logout-link')

#  @login_link: '#login-link'
#  @register_link: '#register-link'
#  @logout_link: '#logout-link'
#
#  @set_up_login_events: ->
#    $(@login_link).click ->
#      alert('fdsa')
#    $(@register_link).click ->
#      alert('fdsa')
#    $(@logout_link).click ->
#      alert('fdsa')