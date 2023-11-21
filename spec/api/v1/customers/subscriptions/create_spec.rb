require "rails_helper"

RSpec.describe "Customer Subscription Create" do
  describe "When the backend receives a request to attach a subscription to a customer with a valid customer_id and the necessary subscription details" do
    it "creates a new record in the database with the subscription being added to the correct customer and sends a response to the frontend with the message 'subscription added successfully' and a 201 status code" do
      customer = Customer.create!(first_name: "Lane", last_name: "Bretschneider", email: "lane@example.com", address: "123 Lane St, Lane, CO 12345")

      post "/api/v1/customers/subscriptions", params: {customer_id: customer.id, title: "All the... Fall Things", price: 100, status: 1, frequency: 1}

      expect(response).to be_successful
      expect(response.status).to eq(201)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to be_a(Hash)
      expect(response_body).to have_key(:success)
      expect(response_body[:success]).to eq("Subscription added successfully")
      expect(response_body).to have_key(:status)
      expect(response_body[:status]).to eq(201)
    end
  end

  describe "When the backend receives a request to attach a subscription to a customer without a valid customer_id" do
    it "sends a response to the frontend with an error message saying 'customer not found' and a status code of 404" do
      post "/api/v1/customers/subscriptions", params: {customer_id: 1, title: "All the... Fall Things", price: 100, status: 1, frequency: 1}

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to be_a(Hash)
      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to eq("Customer not found")
      expect(response_body).to have_key(:status)
      expect(response_body[:status]).to eq(404)
    end
  end

  describe "When the backend receives a request to attach a subscription to a customer with a valid customer_id but without all valid subscription info" do
    it "sends a response to the frontend with an error message saying 'missing [attribute]' and a status code of 400" do
      customer = Customer.create!(first_name: "Lane", last_name: "Bretschneider", email: "lane@example.com", address: "123 Lane St, Lane, CO 12345")

      post "/api/v1/customers/subscriptions", params: {customer_id: customer.id, title: "All the... Fall Things", status: 1, frequency: 1}

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to be_a(Hash)
      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to eq("Price can't be blank")
      expect(response_body).to have_key(:status)
      expect(response_body[:status]).to eq(400)
    end
  end
end