class CommentMailer < ApplicationMailer

	default :from => 'goel.arungoel.arun@gmail.com'


	def new_comment_email(comment)
	    @comment = comment
	    card= Card.find(@comment.card_id)

	    mail( :to => card.from,
	    :subject => 'You got a comment' )

	end

end
