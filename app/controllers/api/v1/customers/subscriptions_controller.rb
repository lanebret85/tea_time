class Api::V1::Customers::SubscriptionsController < ApplicationController
  def create
    begin
      customer = Customer.find(params[:customer_id])
      subscription = Subscription.new(title: params[:title], price: params[:price], status: params[:status].to_i, frequency: params[:frequency].to_i, customer_id: customer.id)
      if subscription.save
        render json: { success: "Subscription added successfully", status: 201 }, status: 201
      else
        render json: { error: subscription.errors.full_messages.to_sentence, status: 400 }, status: 400
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: "Customer not found", status: 404 }, status: 404
    end
  end

  def update
    begin
      subscription = Subscription.find(subscription_params[:id])
      subscription.update(status: subscription_params[:status].to_i)
      render json: { success: "Subscription canceled successfully", status: 200 }, status: 200
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: "Subscription not found", status: 404 }, status: 404
    rescue ArgumentError => e
      render json: { error: "Invalid subscription status", status: 400 }, status: 400
    end
  end

  private

  def subscription_params
    params.permit(:id, :status)
  end
end