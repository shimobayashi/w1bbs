require 'uri'

class Message < ActiveRecord::Base
  belongs_to :forum
  attr_accessible :body, :name, :position, :email
  validates :body, :presence => true, :length => {:maximum => 1024}, :lines_limit => true
  validates :email, :email => true, :length => {:maximum => 50}
  validates :name, :length => {:maximum => 50}
  validates :forum, :message_limit => true
  before_validation :position, :on => :create do
    if self.forum && last_message = self.forum.messages.last
      self.position = last_message.position + 1
    else
      self.position = 1
    end
  end
  before_validation :name, :on => :create do
    return unless self.name.is_a?(String)
    self.name = self.name[0, 50] if self.name.length > 50
  end
  before_save do
    self.forum.touch unless self.email == 'sage'
  end

  def self.filtered(forum, filter)
    case filter
    when /^l([0-9]+)$/
      o = forum.messages.length - $1.to_i
      o = 0 if o < 0
      where('position = 1 OR position > ?', o).order(:position)
    when /^([0-9]+)?-([0-9]+)?$/
      s = $1.to_i
      s = 0 unless s
      e = $2.to_i
      e = 1000 if !e or e < s
      where('position = 1 OR (position >= ? AND position <= ?)', s, e).order(:position)
    when /^([0-9]+)$/
      where(:position => $1.to_i)
    else
      order(:position)
    end
  end

  def body_html
    Rails.cache.fetch("body_html_#{self.id}") do
      body = CGI::escapeHTML(self.body)
      body.gsub!(/\n/, '<br />')
      URI.extract(body, ['http', 'https']).each do |url|
        raw_url = CGI::unescapeHTML(url)
        body.gsub!(url, "<a href='#{URI.escape(raw_url, /[^-_.!~*()a-zA-Z\d;\/?:@&=+$,\[\]%]/n)}' target='_blank'>#{url}</a>") # Escape include single quote and no escape persent
      end
      body.gsub!(/&gt;&gt;([0-9]+)?(-([0-9]+))?/) do
        "<a href='/forums/#{self.forum.id}/#{$1}#{$2}'>#{$&}</a>"
      end
      body
    end
  end
end
