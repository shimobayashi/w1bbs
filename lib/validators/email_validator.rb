# see http://memo.yomukaku.net/entries/166

require 'mail'

class EmailValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    return if value == ''

    begin
      addr = Mail::Address.new(value)
      res = addr.domain && addr.address == value

      tree = addr.__send__(:tree) # Call private method by __send__
      res &&= (tree.domain.dot_atom_text.elements.size > 1)
    rescue Exception => e
      p e
      res = false
    end
    object.errors[attribute] << (options[:message] || 'invalid address!') unless res
  end
end
