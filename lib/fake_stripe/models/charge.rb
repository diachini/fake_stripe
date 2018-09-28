module FakeStripe
  class Charge < Struct.new(:owned_card_ids, :params)
    def valid?
      customer_id.nil? || owned_card_ids.include?(card_id)
    end

    def response
      {
        amount: amount,
        customer: customer_id,
        card: {
          id: card_id,
          address_city: nil,
          address_country: nil,
          address_line1: nil,
          address_line1_check: nil,
          address_line2: nil,
          address_state: nil,
          address_zip: nil,
          address_zip_check: nil,
          country: "US",
          cvc_check: "pass",
          exp_month: 11,
          exp_year: 2014,
          fingerprint: "qhjxpr7DiCdFYTlH",
          last4: "4242",
          name: "john doe",
          object: "card",
          type: "Visa"
        },
        amount_refunded: 0,
        application_fee: nil,
        balance_transaction: "txn_17bBUd2eZvKYlo2CAv3mOn7F",
        captured: true,
        created: 11456245794,
        currency: "usd",
        description: "Charge for VirtuMedix consultation for Guy Henggeler",
        destination: nil,
        dispute: nil,
        failure_code: nil,
        failure_message: nil,
        fee: 59,
        fee_details: [
          {
            amount: 59,
            application: nil,
            currency: "usd",
            description: "Stripe processing fees",
            type: "stripe_fee"
          }
        ],
        fraud_details: {
        },

        id: "ch_1HLqBx9AyixBof",
        invoice: nil,
        livemode: false,
        metadata: {
        },
        object: "charge",
        order: nil,
        paid: true,
        refunded: false,
        refunds: {
          object: "list",
          data: [
          ],
          has_more: false,
          total_count: 0,
          url: "/v1/charges/ch_17hjFm2eZvKYlo2Cf6ceKOqV/refunds"
        },
        shipping: nil,
        source: {
          id: "card_17hjFk2eZvKYlo2CuvsYuAE1",
          object: "card",
          address_city: nil,
          address_country: nil,
          address_line1: nil,
          address_line1_check: nil,
          address_line2: nil,
          address_state: nil,
          address_zip: nil,
          address_zip_check: nil,
          brand: "Visa",
          country: "US",
          customer: customer_id,
          cvc_check: "pass",
          dynamic_last4: nil,
          exp_month: 2,
          exp_year: 2017,
          funding: "credit",
          last4: "4242",
          metadata: {
          },
          name: nil,
          tokenization_method: nil
        },
        statement_descriptor: nil,
        status: "succeeded"
      }
    end

    def error
      {
        error: {
          type: "invalid_request_error",
          message: "Customer #{customer_id} does not have card with ID #{card_id}",
          param: "card"
        }
      }
    end

    private

    def customer_id
      params[:customer]
    end

    def card_id
      params[:card]
    end

    def amount
      params[:amount].to_i
    end
  end
end
