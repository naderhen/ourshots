class LoginControllerStylesheet < ApplicationStylesheet
  # Add your view stylesheets here. You can then override styles if needed, example:
  # include FooStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.white
  end

  def nader_login_button(st)
  	st.text = "Login as Nader"
  	st.frame = "b8:i9"
  end

  def lindsay_login_button(st)
  	st.text = "Login as Lindsay"
  	st.frame = "b10:i11"
  end
end
