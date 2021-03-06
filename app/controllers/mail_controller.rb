require "google/apis/gmail_v1"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"

class MailController < ApplicationController

# Initially I was trying to set the initial date from which it started the last time but here it was not able to handle that. 
# So I am getting mails with a subject "app subject" and trying to get 10 mails from the most recent mail.


	OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
	APPLICATION_NAME = "Gmail API Ruby Quickstart".freeze
	CREDENTIALS_PATH = (Dir.pwd +  "/credentials.json").freeze
	

	# The file token.yaml stores the user's access and refresh tokens, and is
	# created automatically when the authorization flow completes for the first
	# time.

	working_dir = Dir.pwd
	TOKEN_PATH = ( working_dir + "/config/token.yaml").freeze

	SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_READONLY
	initial_date = "Thu, 18 Jun 2020 16:36:52 +0000 (UTC)"
	final_date =  "Thu, 18 Jun 2020 16:36:52 +0000 (UTC)"

	##
	# Ensure valid credentials, either by restoring from the saved credentials
	# files or intitiating an OAuth2 authorization. If authorization is required,
	# the user's default browser will be launched to approve the request.

	def authorize
	  client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
	  token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
	  authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
	  user_id = "default"
	  credentials = authorizer.get_credentials user_id
	  if credentials.nil?
	    url = authorizer.get_authorization_url base_url: OOB_URI
	    puts "Open the following URL in the browser and enter the " \
	         "resulting code after authorization:\n" + url
	    code = gets
	    credentials = authorizer.get_and_store_credentials_from_code(
	      user_id: user_id, code: code, base_url: OOB_URI
	    )
	  end
	  credentials
	end


	def retrieve
		service = Google::Apis::GmailV1::GmailService.new
		service.client_options.application_name = APPLICATION_NAME
		service.authorization = authorize


		# Show the user's labels
		user_id = "me"
		result = service.list_user_labels user_id

		@emails = service.list_user_messages('goel.arungoel.arun@gmail.com')
		email_array = []
		j=0
		if set = @emails.messages
		  	set.each do |i|
			    email = service.get_user_message('goel.arungoel.arun@gmail.com', i.id)  
			         
		    	my_email = {date: email.payload.headers.find {|h| h.name == "Date" }.value}
		    	
		    	
		    	email_array.push(my_email)
		    	j = j+1
		  
		    	if email.payload.headers.find{|h| h.name == "Subject"}.value == "app subject"
		    		c=Card.new
		    		c.user_id=1
		    		c.assigned = false
		    		c.from = email.payload.headers.find{|h| h.name == "From"}.value
		    		c.save 
		    	end

		    	if j==1

		    	end
		    	# braking the loop when 10 emails are traversed
		    	if j==10
		    		break
		    	end
		  	end
		end

		render json: {status: 200, msg: 'User was created.'}
		# email_array
	end

	# def send
	# 	m = Mail.new(
	# 	to: "arungoel9922@gmail.com", 
	# 	from: "goel.arungoel.arun@gmail.com", 
	# 	subject: "Test Subject",
	# 	body:"Test Body")

	# 	service = Google::Apis::GmailV1::GmailService.new
	# 	service.client_options.application_name = APPLICATION_NAME
	# 	service.authorization = authorize
	# 	msg = m.encoded
	# 	message_object = Google::Apis::GmailV1::Message.new(raw:m.to_s)
	# 	service.send_user_message("me", message_object)

	# end

	# def send	
	# 	message = Google::Apis::GmailV1::Message.new
	#     service = Google::Apis::GmailV1::GmailService.new
	#     service.authorization = authorize
	    
	#     message = Mail.new(
	# 	to: "arungoel9922@gmail.com", 
	# 	from: "goel.arungoel.arun@gmail.com", 
	# 	subject: "Test Subject",
	# 	body:"Test Body"
	# 	)
	#     # service.request_options.authorization = current_user.token.fresh_token
 #    	result = service.send_user_message("me", message)

	# end




end
