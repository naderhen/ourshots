class AppDelegate
  attr_reader :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    UIApplication.sharedApplication.registerForRemoteNotificationTypes(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    main_controller = MainController.new
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(main_controller)

    @window.makeKeyAndVisible
    true
  end

  def application(application, didRegisterForRemoteNotificationsWithDeviceToken: device_token)
    NSLog("My token is: %@", device_token)
  end

  def application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    NSLog(error.inspect)
  end
end
