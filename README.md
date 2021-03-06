# BIMserver 1.5.162 

To run the server:
<b>docker run -it --name bimserver -p 8080:8080 asti/bimserver:1.5.162</b>

After the server is up and running go to http://localhost:8080

Configure the server and install the <a href="https://github.com/astmnk/docker-bimserver/raw/main/bimserver_1.5.162_plugins.zip">plugins</a> manually before finishing the setup process.</br>
It's recommended to configure the mail server so you can activate the admin account otherwise you will have problems logging in from OpenMAINT/CMDBuild.</br>
If you don't want to configure the mail server, request a reset password form bimvie.ws <b>(using username: admin@bimserver.org password: admin)</b> so you can find the activation link from the logs located in /usr/local/tomcat/webapps/ROOT/WEB-INF/logs/bimserver.log

<b>docker exec -it bimserver /bin/bash</b>

then type command:

<b>cat webapps/ROOT/WEB-INF/logs/bimserver.log</b>

you will find something like: </br>
<i>
You or someone else has requested your password to be reset, please click the following link to choose a new password: http://localhost:8080/apps/bimviews/?page=ResetPassword&username=admin@bimserver.org&uoid=131074&validationtoken=54C3D15EDEAA5FAA9AEC13210BE5E7F5
</i>

Copy the activation link and reset/activate the admin user.
