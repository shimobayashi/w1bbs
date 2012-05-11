require 'uri'

class Message < ActiveRecord::Base
  belongs_to :forum
  attr_accessible :body, :name, :position, :email
  validates :body, :presence => true, :length => {:maximum => 1024}
  validates :name, :length => {:maximum => 32}
  validates :email, :length => {:maximum => 128}
  validates :forum, :message_limit => true
  before_validation :position, :on => :create do
    if self.forum && last_message = self.forum.messages.last
      self.position = last_message.position + 1
    else
      self.position = 1
    end
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
    body = CGI::escapeHTML(self.body)
    body.gsub!(/\n/, '<br />')
    URI.extract(body).each do |url|
      body.gsub!(url, "<a href='#{url}' target='_blank'>#{url}</a>")
    end
    body.gsub!(/&gt;&gt;([0-9]+)?(-([0-9]+))?/) do
      "<a href='#{Rails.application.routes.url_helpers.forum_path(self.forum, :filter => "#{$1}#{$2}")}'>#{$&}</a>"
    end
    return body
  end
end
