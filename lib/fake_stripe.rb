require 'fake_stripe/configuration'
require 'fake_stripe/exceptions'
require 'fake_stripe/initializers/webmock'
require 'fake_stripe/models'
require 'fake_stripe/stub_app'
require 'fake_stripe/stub_stripe_js'

if defined?(RSpec)
  require 'fake_stripe/rspec'
end

module FakeStripe
  extend Configuration

  VALID_CARD_NUMBER = '4242424242424242'
  STRIPE_OBJECTS = %w{card charge coupon customer invoice invoiceitem plan
    recipient refund subscription token transfer}.freeze
  CARD_OBJECT_TYPE = "card"
  BANK_ACCOUNT_OBJECT_TYPE = "bank_account"
  CUSTOMER_ID = "cus_7xeYRmuGuwvZK1"

  STRIPE_OBJECTS.each do |object|
    define_singleton_method "#{object}_calls" do
      instance_variable_get("@#{object}_calls")
    end

    define_singleton_method "#{object}_calls=" do |calls|
      instance_variable_set("@#{object}_calls", calls)
    end
  end

  class << self
    attr_accessor :charge_calls
    attr_accessor :customer_cards
  end

  def self.cards
    customer_cards.values
  end

  def self.card_ids
    customer_cards.keys
  end

  def self.reset
    STRIPE_OBJECTS.each do |object|
      instance_variable_set("@#{object}_calls", [])
    end
    self.customer_cards = {}
  end

  def self.stub_stripe
    Stripe.api_key = 'FAKE_STRIPE_API_KEY'
    FakeStripe.reset
    FakeStripe::StubStripeJS.boot_once
    stub_request(:any, /api.stripe.com/).to_rack(FakeStripe::StubApp)
  end
end

STRIPE_JS_HOST = "http://localhost:#{FakeStripe::StubStripeJS.server_port}"
