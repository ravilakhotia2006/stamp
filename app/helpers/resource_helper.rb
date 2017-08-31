module ResourceHelper

  def access_response(status, message='')
    Stamp::AccessResponse.new(status: status, message: message)
  end

  def to_enum(status)
    case status
    when :GRANTED
      0
    when :AWAITING_RESPONSE
      1
    when :ACCESS_DENIED
      2
    else
      raise Error::StatusNotFound
    end
  end
end
