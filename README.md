ourshots
===================

require 'houston'
require 'pry'

# Environment variables are automatically read, or can be overridden by any specified options. You can also
# conveniently use `Houston::Client.development` or `Houston::Client.production`.
APN = Houston::Client.development
APN.certificate = File.read("/Users/nhendawi/Dropbox/ios_certs/apple_push_notification.pem")

# An example of the token sent back when a device registers for notifications
token = "<934d08a6 307d54eb 78ca8ad9 6a0c6baf 57c2e51f c66e8504 f48fc2b5 42986a67>"
# token = "<ce8be627 2e43e855 16033e24 b4c28922 0eeda487 9c477160 b2545e95 b68b5969>"

# Create a notification that alerts a message to the user, plays a sound, and sets the badge on the app
notification = Houston::Notification.new(device: token)
notification.alert = "NADER RULES!"

# Notifications can also change the badge count, have a custom sound, indicate available Newsstand content, or pass along arbitrary data.
notification.badge = 57
notification.sound = "sosumi.aiff"
notification.content_available = true
notification.custom_data = {foo: "bar"}

APN.push(notification)
