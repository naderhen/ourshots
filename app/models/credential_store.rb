class CredentialStore
  SERVICE = 'OurShots'

  def self.sharedClient
    Dispatch.once { @instance ||= new }
    @instance
  end
  
  def set_secure_value(value, for_key: key)
    if value
      SSKeychain.setPassword(value, forService: SERVICE, account: key)
    else
      SSKeychain.deletePasswordForService(SERVICE, account: key)
    end
  end
 
  def secure_value_for_key(key)
    SSKeychain.passwordForService(SERVICE, account: key)
  end
end