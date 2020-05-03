# rails-online-shop
Online E-cart store

This application is for the E-cart website that is build using Ruby on Rails

The application is hosted on : https://vast-mountain-92690.herokuapp.com/ which is the production deployement of the website using Heroku cloud base.

If the user wants to setup the application on the local system :

He can follow the following steps :

1) Download the application on to your local system. ( Make sure you have Rails installed and have a Ruby version '2.7.0')

2) You will also need to have the latest node version on your system as well as 'yarn' installed.

3) You could open the application up on command line or Ruby Mine(prefered option).

4) Once the application is open, first run bundle install on the ruby console or the command line interface. This step will allow you to install all the dependencies that is specified on the gemfile for the project.

5)Once you have setup the project and run bundle install - you can proceed to run rails server in the rubymine terminal or the command line interface which will allow you to run the server for this application.

6)If the setup was done in proper manner, your server will start up successfully and run.

7) On successful start of the server you will be able to run the app on reaching out to http://localhost:3000/ on your browser. This will take you the welcome page of the application.

8) In order to setup the admin details for the system, you could use the command - User.create!(name: "test", email: "test@example.com", password: "testuser123" , role: ”admin”) by opening the rails console. Running this will create an admin for the system, that will allow you to login and access the admin controls of the system.

