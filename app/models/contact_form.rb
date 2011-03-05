class ContactForm < ActiveRecord::Base
  attr_accessor :token, :url

  validates_presence_of     :name, :message
  validates_length_of       :email,    :within => 3..100
  validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validate :honeypot_comment

  def honeypot_comment
    errors.add(:url, "You must be a bot!") unless url.empty?
  end

end
