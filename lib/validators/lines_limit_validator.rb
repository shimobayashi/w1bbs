class LinesLimitValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if value && value.split("\n").length > 16
      object.errors[attribute] << (options[:message] || 'cant over 16 lines!')
    end
  end
end
