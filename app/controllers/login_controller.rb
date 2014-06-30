class LoginController < UIViewController

  def viewDidLoad
    super

    rmq.stylesheet = LoginControllerStylesheet
    rmq(self.view).apply_style :root_view

    # Create your views here

    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemRefresh,
                                                                           target: self, action: :log_out)

    @lindsay_login_button = rmq(self.view).append(UIButton, :lindsay_login_button).get

    rmq(@lindsay_login_button).on(:tap) do |sender, event|
      log_in('soltisl@gmail.com')
    end

    @nader_login_button = rmq(self.view).append(UIButton, :nader_login_button).get

    rmq(@nader_login_button).on(:tap) do |sender, event|
      log_in('naderhen@gmail.com')
    end
  end

  def log_in(email)
    AFMotion::JSON.delete(API_URL + "/sessions.json") do |logout_result|
      ap "Logging out"
      CredentialStore.sharedClient.set_secure_value(nil, for_key: "user_token")
      CredentialStore.sharedClient.set_secure_value(nil, for_key: "user_email")

      AFMotion::JSON.post(API_URL + "/sessions.json", user: {email: email, password: "test1234"}) do |result|
        ap result
        if result.error
          ap result.error.localizedDescription
        elsif result.success? && result.object["data"]["auth_token"]
          CredentialStore.sharedClient.set_secure_value(result.object["data"]["auth_token"], for_key: "user_token")
          CredentialStore.sharedClient.set_secure_value(email, for_key: "user_email")
          self.navigationController.pushViewController(GroupsController.new, animated: true)
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
