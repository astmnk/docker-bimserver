# BIMserver image

1. BIMserver version 1.5.182 <b>docker pull asti/bimserver:1.5.182</b>
2. BIMserver version 1.5.162 <b>docker pull asti/bimserver:1.5.162</b>
3. BIMserver version 1.5.138 <b>docker pull asti/bimserver:1.5.138</b>

### Run the server:

BIMserver 1.5.138
```
docker run -it -e JAVA_OPTS='-Xmx4g' --name bimserver -p 8080:8080 asti/bimserver:1.5.138
```
BIMserver 1.5.162
```
docker run -it -e JAVA_OPTS='-Xmx4g' -v <local folder path>:/usr/local/bimserver/home -p 8080:8080 --name bimserver asti/bimserver:1.5.162
```
BIMserver 1.5.182
```
docker run -it -e JAVA_OPTS='-Xmx4g' -v <local folder path>:/usr/local/bimserver/home -p 8080:8080 --name bimserver asti/bimserver:1.5.182
```


After the server is up and running go to http://localhost:8080

(<b>Important!</b>)
First time run - If you run into problems installing the BIMserver (version 1.5.138 or 1.5.162) plugins from internet, configure the server and install the plugins  <b>manually</b> (using <a href="https://raw.githubusercontent.com/astmnk/docker-bimserver/e0d84c3f95527ee92c5c5554a5b7dd34a2d5a208/bimserver_1.5.162_plugins.zip">1.5.162</a> or <a href="https://raw.githubusercontent.com/astmnk/docker-bimserver/e0d84c3f95527ee92c5c5554a5b7dd34a2d5a208/bimserver_1.5.138_plugins.zip">1.5.138</a> - based on the version of bimserver) before finishing the setup process.</br>

(If used with OpenMAINT - BIMserver 1.5.138) It's recommended to configure the mail server so you can activate the admin account otherwise you will have problems logging in from OpenMAINT/CMDBuild.</br>
If you don't want to configure the mail server, request a reset password form <a href='http://localhost:8080/apps/bimviews/'>bimviews</a> <i>(using username and password from the first setup page)</i> so you can find the activation link from the logs located in /usr/local/bimserver/home/logs/bimserver.log

```
docker exec -it bimserver /bin/bash
```

then type command:
```
cat /usr/local/bimserver/home/logs/bimserver.log
```

you will find something like: </br>
```
You or someone else has requested your password to be reset, please click the following link to choose a new password: http://localhost:8080/apps/bimviews/?page=ResetPassword&username=admin@bimserver.org&uoid=131074&validationtoken=54C3D15EDEAA5FAA9AEC13210BE5E7F5
```

Copy the activation link and reset/activate the admin user.

### Build image from Dockerfile (Bimserver 1.5.182)
Instructions:
- Build image:
```
docker build -t asti/bimserver:1.5.182 .
```

- Run container:
```
Note: <local folder path> - path in you local machine
```

```
docker run -it -e JAVA_OPTS='-Xmx4g' -v <local folder path>:/usr/local/bimserver/home -p 8080:8080 --name bimserver <bimserver image name>
```
example:
```
docker run -it --rm -e JAVA_OPTS='-Xmx4g' -v /home/bimserver_home:/usr/local/bimserver/home -p 8080:8080 --name bimserver asti/bimserver:1.5.182
```

