class CameraControllerStylesheet < ApplicationStylesheet
  # Add your view stylesheets here. You can then override styles if needed, example:
  # include FooStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.white
  end

  def image_view(st)
  	st.frame = "b1:i9"
  end

  def take_picture_button(st)
  	st.frame = "b10:i11"
  	st.text = "Shoot!"
  end
end
