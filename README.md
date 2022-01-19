# Desafio Log Parser

### This web application uses the ruby language version 3.1.0, so there are some things you should do to run it properly.

 ## install the RVM to run the ruby version 3.1.0 the following steps should the followed:

  You need software-properties-common installed in order to add PPA repositories, so to install run this line on terminal:
   ``` $ sudo apt-get install software-properties-common ``` 

After run:
 ``` $ sudo apt-add-repository -y ppa:rael-gc/rvm ```
 ``` $ sudo apt-get update ```
 ``` $ sudo apt-get install rvm ```

Then add your use to rvm group ($USER will automatically insert your username):
 ``` $ sudo usermod -a -G rvm $USER ```

Change your terminal window
At terminal window, click Edit > Profile Preferences, click on Title and Command tab and check Run command as login shell.

Then reboot the system, to do the nexts steps.

After reboot the system run:
 ``` $ rvm user gemsets ```

### to finaly install ruby 
 ``` $ rvm install ruby 3.1.0 ```


### To install all the dependences for the application, run:
 ``` $ bundle install ```

 ## To run the application:
   ```ruby main.rb  ```

 ### and to check the application tests, run:
 ``` $ rspec ```
