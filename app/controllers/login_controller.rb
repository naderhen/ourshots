class LoginController < UIViewController

  def viewDidLoad
    super

    rmq.stylesheet = LoginControllerStylesheet
    rmq(self.view).apply_style :root_view

    # Create your views here
    @login_button = rmq(self.view).append(UIButton, :login_button).get

    rmq(@login_button).on(:tap) do |sender, event|
      email = "soltisl@gmail.com"
      AFMotion::JSON.post(API_URL + "/sessions", user: {email: email, password: "test1234"}) do |result|
        if result.success? && result.object["data"]["auth_token"]
          CredentialStore.sharedClient.set_secure_value(result.object["data"]["auth_token"], for_key: "user_token")
          CredentialStore.sharedClient.set_secure_value(email, for_key: "user_email")
        end
      end
    end
  end

  # Remove if you are only supporting portrait
  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAll
  end

  # Remove if you are only supporting portrait
  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    rmq.all.reapply_styles
  end
end


__END__

# You don't have to reapply styles to all UIViews, if you want to optimize,
# another way to do it is tag the views you need to restyle in your stylesheet,
# then only reapply the tagged views, like so:
def logo(st)
  st.frame = {t: 10, w: 200, h: 96}
  st.centered = :horizontal
  st.image = image.resource('logo')
  st.tag(:reapply_style)
end

# Then in willAnimateRotationToInterfaceOrientation
rmq(:reapply_style).reapply_styles
