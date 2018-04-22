# Robot Framework Docker Support

> Why choose the docker [kenith/robotframework-docker](https://hub.docker.com/r/kenith/robotframework-docker/) for Robot Framework: 
> 1. With no VNC supports, we could debug our script easier and more flexible if any error occurs during the test
![alt text](https://raw.githubusercontent.com/Kenith/robotframework-docker/dev/noVPC_Sample.png)
> 2. Support Python 2.7, and Python 3.6 for Robot Framework, such as robot, robot2, robot3
> 3. Installed browsers, such as Chrome, Firefox, PhantomJS for testing
> 4. We are working on a FREE workshop for Robot Framework

## Content
- [Build](#build)
- [Supports](#supports)
- [User Docker Step by Step](#use-docker-step-by-step)
- [Use Docker Directly](#use-docker-directly)
- [Useful Links](#useful-links)

## Build
Get the source and sample from git hub [kenith/robotframework-docker](https://github.com/Kenith/robotframework-docker), and build image: `docker build -t robotframework-docker .`

Or, pull the image from docker hub - [kenith/robotframework-docker](https://hub.docker.com/r/kenith/robotframework-docker/): `docker pull kenith/robotframework-docker:latest`

## Supports
Support the Robot Framework based on Python2.7 & Python 3.6.

With No VPC support, we could debug the scripts more flexible.

1. Python 2.7

    **Packages**
    > **Note:** Suggest to use robotframework-seleniumlibrary for testing

    - [robotframework 3.0.3](https://pypi.org/project/robotframework/)
    - [robotframework-seleniumlibrary 3.1.1](https://pypi.org/project/robotframework-seleniumlibrary/)
    - [robotframework-selenium2library 1.8.0](https://pypi.org/project/robotframework-selenium2library/1.8.0/)
    - [robotframework-pabot 0.44](https://pypi.org/project/robotframework-pabot/)
    
    **Robot Command**
    
    - `robot --version`
    - `robot2 --version`
    - `pybot --version`
    - `pybot2 --version`
    - `rebot --version`
    - `rebot2 --version`
    - `pabot --version`
    - `pabot2 --version`

2. Python 3.6

    **Packages**

    - [robotframework 3.0.3](https://pypi.org/project/robotframework/)
    - [robotframework-seleniumlibrary 3.1.1](https://pypi.org/project/robotframework-seleniumlibrary/)
    - [robotframework-pabot 0.44](https://pypi.org/project/robotframework-pabot/)
    
    **Robot Command**
    - `robot3 --version`
    - `pybot3 --version`
    - `rebot3 --version`
    - `pabot3 --version`

3. Browsers

    - Chrome v66.0.3359.117 - ChromeDriver v2.38
    - Firefox v59.0.2 - Geckodriver v0.20.1
    - PhantomJS v2.1.1 

## Use Docker Step by Step
**1. Assuming that you have copied the "Sample" folder to the ~/Debug to assign the local path ~/Debug to docker path /tmp, and start the docker container**
   ```
   docker run \
        -v ~/Debug:/tmp \
        --rm \
        -p 6901:6901 \
        -p 5901:5901 \
        --shm-size 2048m \
        kenith/robotframework-docker:latest
   ```
   
**2. Access the [http://localhost:6901/?password=vncpassword/](http://localhost:6901/?password=vncpassword/) to the noVNC Env**
![alt text](https://raw.githubusercontent.com/Kenith/robotframework-docker/dev/noVPC_Sample.png)

**3. Open terminal and cd to your folder: cd /tmp**

**4. Run Test**

- Run Test (use default browser - Chrome)

```
# Python 2.7
robot --outputdir Report/RunTest sample_1.robot

# Python 3.6
robot3 --outputdir Report/RunTest sample_1.robot
```

- Run Parallel Test (use browser - Firefox)

```
# Python 2.7
pabot --processes 2 --outputdir Report/RunParallelTest --variable BROWSER:Firefox *.robot

# Python 3.6
pabot3 --processes 2 --outputdir Report/RunParallelTest --variable BROWSER:Firefox *.robot
```

- Run Cross Browsers Test

```
# Python 2.7
pabot --argumentfile1 firefox.args --argumentfile2 chrome.args --processes 4 --outputdir Report/RunCrossBrowserTest *.robot

# Python 3.6
pabot3 --argumentfile1 firefox.args --argumentfile2 chrome.args --processes 4 --outputdir Report/RunCrossBrowserTest *.robot
```

## Use Docker Directly
**1. Assume you have copied the folder "Sample" to the ~/Debug**

**2. Run Test (python 2.7 as reference)**

- Run Test (use default browser - Chrome) 

```
docker run \
    -v ~/Debug:/tmp \
    --rm \
    -p 6901:6901 \
    -p 5901:5901 \
    --shm-size 2048m \
    kenith/robotframework-docker:latest \
    robot --outputdir Report/RunTest sample_1.robot
```
    
- Run Parallel Test (use browser - Firefox)

```
docker run \
    -v ~/Debug:/tmp \
    --rm \
    -p 6901:6901 \
    -p 5901:5901 \
    --shm-size 2048m \
    kenith/robotframework-docker:latest \
    pabot --processes 2 --outputdir Report/RunParallelTest --variable BROWSER:Firefox *.robot
```

- Run Cross Browsers Test
```
docker run \
    -v ~/Debug:/tmp \
    --rm \
    -p 6901:6901 \
    -p 5901:5901 \
    --shm-size 2048m \
    kenith/robotframework-docker:latest \
    pabot --argumentfile1 firefox.args --argumentfile2 chrome.args --processes 4 --outputdir Report/RunCrossBrowserTest *.robot
```

## Useful Links
1. [Robot Build In Library](http://robotframework.org/robotframework/#standard-libraries)
2. [Selenium Library](http://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)
3. [All Possible Library](http://robotframework.org/robotframework/#standard-libraries)
