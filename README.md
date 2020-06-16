# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Ticket System

About app:
This is the backend for an application “Ticket System”. In this I have tried making the for this app in rails platform in ruby language. It fetches email from the GMAIL with a particular subject , in this it is “ app subject”  and makes a card for that email. There are many users, and admin. Admin can assign that card to any of the user. 


Getting Started:
Clone this application.
Install all the gems.
Construct the database.
U can make any user by signing up but making a user admin, u need to go to the backend and then change its role from “user” to “admin”.
As soon as the user will sign in, he can see all the cards unassigned.

Explanation:

Controllers:
Users : It handle all the actions for user like creating a user, updating , destroy, admin_login etc.
Card: It handle all the actions for card .
Mails: It contains actions for retrieving mails from my gmail message box and makes card and marks them unassigned.
Home controller and user_token controller helps in authenticating the user.


Future Work:
Applying search bar for searching emails .
Making a dashboard for admin which contains all the assigned mails as well as unassigned mails.




