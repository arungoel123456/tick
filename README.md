# Ticket System

## About app:
This is the backend for an application “Ticket System”. In this I have tried making the for this app in rails platform in ruby language. It fetches email from the GMAIL with a particular subject , in this it is “ app subject”  and makes a card for that email. There are many users, and admin. Admin can assign that card to any of the user. 


## Getting Started:
1. Clone this application.
2. Install all the gems.
3. Construct the database.
4. U can make any user by signing up but making a user admin, u need to go to the backend and then change its role from “user” to “admin”.
5. As soon as the user will sign in, he can see all the cards unassigned.

## Explanation:

##### Controllers:
1. Users : It handle all the actions for user like creating a user, updating , destroy, admin_login etc.
2. Card: It handle all the actions for card .
3. Mails: It contains actions for retrieving mails from my gmail message box and makes card and marks them unassigned.
4. Home controller and user_token controller helps in authenticating the user.


## Future Work:
1. Applying search bar for searching emails .
2. Making a dashboard for admin which contains all the assigned mails as well as unassigned mails.
3. Making a dropdown for selecting a user and showing its assigned cards to admin.

