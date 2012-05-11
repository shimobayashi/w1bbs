class MessageLimitValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if value && value.messages.length >= 1000
      object.errors[attribute] << (options[:message] || 'cant over 1000 messages!')
    end
  end
end
