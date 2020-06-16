class UsersController < ApplicationController

	 # Use Knock to make sure the current_user is authenticated before completing request.
  before_action :authenticate_user,  only: [:index, :current, :update, :admin_login]
  before_action :authorize_as_admin, only: [:destroy]
  before_action :authorize,          only: [:update]


  # Method to create a new user using the safe params we setup.
	def create
	  user = User.new(user_params)
	  if user.save  
	    render json: {status: 200, msg: 'User was created.'}
	  end
	end

  # To check if current logged in member is admin or not.
  def admin_login
    if current_user["role"]== "admin"
      render json: { status: 200 , msg: 'Admin is there' }
    else
      render json: { status: 400 , msg: 'Admin is not there' }
    end
  end

  # Getting all the users present or have signed up
  def get_all
    all_users=User.where("role = ?" , "user" )
    render json: all_users
  end

	# Method to update a specific user. User will need to be authorized.
	def update
	  user = User.find(params[:id])
	  if user.update(user_params)
	    render json: { status: 200, msg: 'User details have been updated.' }
	  end
	end

	# Method to delete a user, this method is only for admin accounts.
	def destroy
	  user = User.find(params[:id])
	  if user.destroy
	    render json: { status: 200, msg: 'User has been deleted.' }
	  end
	end
  
  # Should work if the current_user is authenticated.
  # It checks first that if the user is admin, it returns all the cards that are not assigned, and if the user is not admin, then it returns
  # the cards assigned to him.
  def index  
    if current_user["role"]=="admin"
      all_card = Card.where(["assigned= ?" , false  ])
      all_card_json = all_card.to_json
      render json: all_card_json

    else
      all_card = Card.where(["user_id = ? and assigned = ? " , current_user["id"] , true ])
      all_card_json = all_card.to_json
      render json: all_card_json

    end
  end

  
  # Call this method to check if the user is logged-in.
  # If the user is logged-in we will return the user's information.
  def current
    current_user.update!(last_login: Time.now)
    render json: current_user
  end
  
  private
  
  # Setting up strict parameters for when we add account creation.
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  
  # Adding a method to check if current_user can update itself. 
  # This uses our UserModel method.
  def authorize
    return_unauthorized unless current_user && current_user.can_modify_user?(params[:id])
  end

end
