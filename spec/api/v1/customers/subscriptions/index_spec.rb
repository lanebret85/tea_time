require "rails_helper"

RSpec.describe "Customer Subscriptions Index" do
  describe "When the backend receives a request for all of a customer's subscriptions with a valid customer_id" do
    it "sends a response to the frontend with the list of all of that customer's subscriptions and a 200 status code" do
      customer = Customer.create!(first_name: "Lane", last_name: "Bretschneider", email: "lane@example.com", address: "123 Lane St, Lane, CO 12345")
      subscription_1 = customer.subscriptions.create!(title: "All the... Fall Things", price: 100, status: 0, frequency: 1)
      subscription_2 = customer.subscriptions.create!(title: "BeauTEAful Love", price: 75, status: 0, frequency: 2)
      subscription_3 = customer.subscriptions.create!(title: "Summer Fruit Basket", price: 80, status: 1, frequency: 0)

      get "/api/v1/customers/subscriptions", params: {customer_id: customer.id}

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to be_a(Hash)
      
      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to be_an(Array)
      
      subscriptions_array = response_body[:data]

      expect(subscriptions_array.first).to be_a(Hash)

      expect(subscriptions_array.first).to have_key(:id)
      expect(subscriptions_array.first[:id]).to be_a(String)
      
      expect(subscriptions_array.first).to have_key(:type)
      expect(subscriptions_array.first[:type]).to eq("subscription")
      
      expect(subscriptions_array.first).to have_key(:attributes)
      expect(subscriptions_array.first[:attributes]).to be_a(Hash)

      subscription_attributes = subscriptions_array.first[:attributes]

      expect(subscription_attributes).to have_key(:title)
      expect(subscription_attributes[:title]).to be_a(String)
      
      expect(subscription_attributes).to have_key(:price)
      expect(subscription_attributes[:price]).to be_an(Integer)
      
      expect(subscription_attributes).to have_key(:status)
      expect(subscription_attributes[:status]).to be_a(String)
      
      expect(subscription_attributes).to have_key(:frequency)
      expect(subscription_attributes[:frequency]).to be_a(String)
    end
  end

  describe "When the backend receives a request for all of a customer's subscriptions with an invalid customer_id" do
    it "sends a response to the frontend with an error message saying 'Customer not found' and a 404 status code" do
      get "/api/v1/customers/subscriptions", params: {customer_id: 1}

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

  describe "When the backend receives a request for all of a customer's subscriptions with a valid customer_id and the customer that matches that customer_id doesn't have any subscriptions" do
    it "sends a response to the frontend as a hash with a :data key pointing to an empty array" do
      customer = Customer.create!(first_name: "Lane", last_name: "Bretschneider", email: "lane@example.com", address: "123 Lane St, Lane, CO 12345")

      get "/api/v1/customers/subscriptions", params: {customer_id: customer.id}

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to be_a(Hash)
      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to be_an(Array)
      expect(response_body[:data]).to be_empty
    end
  end
end