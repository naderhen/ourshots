class AppDelegate
  attr_reader :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    PixateFreestyle.initializePixateFreestyle
    UIApplication.sharedApplication.registerForRemoteNotificationTypes(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    UIApplication.sharedApplication.applicationIconBadgeNumber = 0

    @window.styleMode = PXStylingNormal
    setup_pixate_monitor if Device.simulator?
    PixateFreestyle.updateStylesForAllViews

    main_controller = CameraController.new
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(main_controller)

    @window.makeKeyAndVisible
    true
  end

  def application(application, didRegisterForRemoteNotificationsWithDeviceToken:deviceToken)
    clean_token = deviceToken.description.gsub(" ", "").gsub("<", "").gsub(">", "")
    NSLog("RECEIVED TOKEN %@ .  REGISTERING", clean_token)
    # 934d08a6307d54eb78ca8ad96a0c6baf57c2e51fc66e8504f48fc2b542986a67
    # show_alert("Push Notification Token", clean_token)

    # AFMotion::JSON.post("http://192.168.1.4:3000/device_tokens", token: clean_token) do |result|
    #   if result.success?
    #     NSLog("SUCCESS!")
    #   end
    # end
  end
  
  def application(application, didReceiveRemoteNotification:userInfo)
    # show_alert("Push Notification Received", "Alert: #{userInfo['aps']}")
    NSLog("RECEIVED!!!!!!!!! %@", userInfo)
  end
  
  def show_alert(title, message)
    alert = UIAlertView.new
    alert.title = title
    alert.message = message
    alert.show
  end

  def setup_pixate_monitor
    PixateFreestyle.styleSheetFromFilePath('/Users/nader/dev/ourshots/resources/default.css', withOrigin:PXStylesheetOriginApplication)
    PixateFreestyle.currentApplicationStylesheet.monitorChanges = true
  end
end
