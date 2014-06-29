class APIClient

  def self.sharedClient
    Dispatch.once { @instance ||= new }
    @instance = AFMotion::SessionClient.build(API_URL) do |client|
      client.session_configuration :default
      ap client
      client.header "Accept", "application/json"
      client.header "X-User-Email", CredentialStore.sharedClient.secure_value_for_key("user_email")
      client.header "X-User-Token", CredentialStore.sharedClient.secure_value_for_key("user_token")

      client.response_serializer :json
    end
  end
end