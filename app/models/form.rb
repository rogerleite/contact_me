class Form < ActiveRecord::Base

  belongs_to :account

  validates_presence_of :subject,  :account
  validates_length_of   :email_to, :within => 3..100
  validates_format_of   :email_to, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  after_create :create_token

  def self.find_by_token(token)
    form_id = decode_token(token).first
    Form.find(form_id)
  end

  private

  def create_token
    self.token = Form.encode_token(self.id, self.account.id)
    self.update_attribute(:token, self.token)
  end

  def self.encode_token(*args)
    Base64.encode64(args.join("|"))
  end

  def self.decode_token(token)
    Base64.decode64(token).split("|")
  end

end
