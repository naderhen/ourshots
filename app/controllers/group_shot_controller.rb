class GroupShotController < UIViewController

  def viewDidLoad
    super

    rmq.stylesheet = GroupShotControllerStylesheet
    rmq(self.view).apply_style :root_view

    # Create your views here
    @image_view = rmq(self.view).append(UIImageView, :image_view).get
    
    @take_picture_button = rmq(self.view).append(UIButton, :take_picture_button).get
    rmq(@take_picture_button).on(:tap) do |sender, event|
      take_picture
    end
  end

  def take_picture
    unless UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceTypeCamera)
      alert = UIAlertView.alloc.initWithTitle('Error',
                                              message: 'Camera Unavailable',
                                             delegate: self,
                                    cancelButtonTitle: 'Cancel',
                                    otherButtonTitles: nil)
      alert.show

      return
    end

    if !@image_picker
      @image_picker = UIImagePickerController.alloc.init
      @image_picker.delegate = self
      @image_picker.sourceType = UIImagePickerControllerSourceTypeCamera
      @image_picker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceTypeCamera)
      @image_picker.allowsEditing = true
      @image_picker.showsCameraControls = false
      @image_picker.cameraDevice = UIImagePickerControllerCameraDeviceFront
      @image_picker.cameraOverlayView = overlay_for_image_picker(@image_picker)
    end

    presentViewController(@image_picker, animated: true, completion: nil)
  end

  def overlay_for_image_picker(image_picker)
    UIView.alloc.initWithFrame(CGRectMake(0, 0, 280, 480)).tap do |overlay|
      overlay.backgroundColor = UIColor.clearColor

      UIButton.alloc.initWithFrame(CGRectMake(100, 432, 120, 44)).tap do |button|
        button.backgroundColor = UIColor.colorWithRed(0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        button.setTitle('Click!', forState: UIControlStateNormal)
        button.setTitleColor(UIColor.whiteColor, forState: UIControlStateNormal)
        button.addTarget(image_picker, action: 'takePicture', forControlEvents: UIControlEventTouchUpInside)
        overlay.addSubview(button)
      end
    end
  end

  def imagePickerController(picker, didFinishPickingMediaWithInfo: info)
    image = info[UIImagePickerControllerOriginalImage]
    # UIImageWriteToSavedPhotosAlbum(image, nil, nil , nil)

    @image_view.image = image
    @image_view.contentMode = UIViewContentModeScaleAspectFill

    dismissViewControllerAnimated(true, completion: nil)
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
