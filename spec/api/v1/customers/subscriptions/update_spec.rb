require "rails_helper"

RSpec.describe "Customer Subscription Update" do
  describe "When the backend receives a request to change a customer's subscription status to 'canceled' and the request includes a valid subscription_id and a valid status" do
    it "updates the subscription record in the database with the status being changed from 'active' to 'canceled' and sends a response to the frontend with the message 'subscription canceled successfully' and a 200 status code" do
      customer = Customer.create!(first_name: "Lane", last_name: "Bretschneider", email: "lane@example.com", address: "123 Lane St, Lane, CO 12345")
      subscription = customer.subscriptions.create!(title: "All the... Fall Things", price: 100, status: 0, frequency: 1)

      patch "/api/v1/customers/subscriptions", params: {id: subscription.id, status: 1}

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to be_a(Hash)
      expect(response_body).to have_key(:success)
      expect(response_body[:success]).to eq("Subscription canceled successfully")
      expect(response_body).to have_key(:status)
      expect(response_body[:status]).to eq(200)
    end
  end

  describe "When the backend receives a request to update a subscription's status without a valid subscription_id" do
    it "sends a response to the frontend with an error message saying 'Subscription not found' and a status code of 404" do
      customer = Customer.create!(first_name: "Lane", last_name: "Bretschneider", email: "lane@example.com", address: "123 Lane St, Lane, CO 12345")

      patch "/api/v1/customers/subscriptions", params: {id: 1, status: 1}

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to be_a(Hash)
      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to eq("Subscription not found")
      expect(response_body).to have_key(:status)
      expect(response_body[:status]).to eq(404)
    end
  end

  describe "When the backend receives a request to update a subscription with a valid subscription_id but without a valid status" do
    it "sends a response to the frontend with an error message saying 'Invalid subscription status' and a status code of 400" do
      customer = Customer.create!(first_name: "Lane", last_name: "Bretschneider", email: "lane@example.com", address: "123 Lane St, Lane, CO 12345")
      subscription = customer.subscriptions.create!(title: "All the... Fall Things", price: 100, status: 0, frequency: 1)

      patch "/api/v1/customers/subscriptions", params: {id: subscription.id, status: 2}

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to be_a(Hash)
      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to eq("Invalid subscription status")
      expect(response_body).to have_key(:status)
      expect(response_body[:status]).to eq(400)
    end
  end
end