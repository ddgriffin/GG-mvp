# app/models/nomination.rb

class Nomination
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include ActionView::Helpers::TextHelper

  attr_accessor :maker_first_name, :maker_last_name, :maker_email, :referrer_first_name, :referrer_last_name, :maker_city, :maker_type

  validates_presence_of :maker_first_name, :message => "Please include your Nominee's first name"
  validates_presence_of :maker_last_name, :message => "Please include your Nominee's last name"
  validates_presence_of :maker_email, :message => "Please include your Nominee's email"
  validates_presence_of :referrer_first_name, :message => "Please include your first name"
  validates_presence_of :referrer_last_name, :message => "Please include your last name"
  validates_presence_of :maker_city, :message => "Please include your Nominee's City"

  validates_format_of :maker_email, :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, :message => "Hmmm, think address@example.com"

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end


  def deliver
    return false unless valid?
    Pony.mail({
      :from => %("#{referrer_first_name} #{referrer_last_name}" <hello@girlsguild.com>),
      :subject => "Nominate a Maker or Apprentice",
      :html_body => %(<p>#{referrer_first_name} #{referrer_last_name} has nominated #{maker_first_name} #{maker_last_name}.</p>
        <p>#{maker_email}</p>
        <p>#{maker_city}</p>
        <p>Nominated as a: #{maker_type}</p>)
    })
    return true
  end

  def persisted?
    false
  end

end