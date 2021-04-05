class AuthService
  prepend BasicService

  AUTH_TOKEN = %r{\ABearer (?<token>.+)\z}

  param :token

  attr_reader :user_id

  def call
    result = Auth::FetchUserService.call(extracted_token['uuid']).user

    @user_id = result.id if result.present?
  end

  def extracted_token
    JwtEncoder.decode(matched_token)
  rescue JWT::DecodeError
    {}
  end

  private

  def matched_token
    result = @token.match(AUTH_TOKEN)
    return if result.blank?

    result[:token]
  end
end
