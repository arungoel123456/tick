class CommentsController < ApplicationController

	def create
		
		comment=Comment.new

		comment.user_id= current_user.id	
		comment.card_id= params[:card_id]
		comment.body= params[:comment]

		if comment.save
	      	CommentMailer.new_comment_email(comment).deliver_now
	      # flash[:success] = "Thank you for your order! We'll get contact you soon!"
	      	card=Card.find(params[:card_id])
			comments=Comment.where("card_id = ?" ,params[:card_id] )
			all_comment_json = comments.to_json
	  		render json: all_comment_json
	    else
	      	flash.now[:error] = "Your order form had some errors. Please check the form and resubmit."
	      	render json: comment
	    end
	end

	def get_all
		card=Card.find(params[:card_id])
		comments=Comment.where("card_id = ?" ,params[:card_id] )
		all_comment_json = comments.to_json
  		render json: all_comment_json
	end

	def destroy
		byebug
		comment=Comment.find(params[:comment_id])
		card_id=comment.card_id
		byebug
		comment.delete()
		comments=Comment.where("card_id = ?" ,card_id)
		all_comment_json = comments.to_json
  		render json: all_comment_json

	end


end
