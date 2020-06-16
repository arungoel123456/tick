class CardController < ApplicationController

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

end
