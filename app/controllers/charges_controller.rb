class ChargesController < ApplicationController

  def new
    @amount = 15_00
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: @amount
    }

  end

  def create
    #Amount in cents
    @amount = 15_00

    #Creates a Stripe Customer object, for associating with the charge

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    #The charge happens here

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "WikiCamp Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Congratulations #{current_user.email}! Your payment was successful!"
    current_user.add_role :premium
    redirect_to wikis_path

    #Rescue block if something goes wrong
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

end
