class Error < StandardError
  class << self

    def const_missing(const_name)
      error_name = const_name.to_s.underscore
      error_message = I18n.t("error.#{error_name}.message")

      return super if error_message.nil?
      Error.new(error_message)
    end
  end
end
