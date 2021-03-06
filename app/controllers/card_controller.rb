class CardController < ApplicationController
	# before_action :authenticate_user,  only: [:show]

	# This is a function that assigns a card to a particular user
	def assign	
		c=Card.find(params[:card_id])
		c.assigned= true
		c.user_id = params[:user_id]
		c.save
		render json: {status: 200, msg: 'Card Assigned'}
	end

	# It returns all the cards that are assigned to anybody.
  	def assigned
	    all_card=Card.where(["assigned = ? " ,  true ])
	    all_card_json = all_card.to_json
	    render json: all_card_json
  	end

  	def unassign
  		c=Card.find(params[:card_id])
  		user_assigned= c.user_id
  		c.assigned= false
  		c.user_id= 1;
  		c.save
  		all_card=Card.where([ "user_id = ? and assigned = ? " ,user_assigned , true ])
  		all_card_json = all_card.to_json
  		render json: all_card_json
  	end

  	def show
  		c=Card.find(params[:card_id])
  		c_json=c.to_json
  		render json: c
  	end

end
