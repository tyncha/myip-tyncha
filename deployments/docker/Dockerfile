## Base image with python3 installed
FROM python:3


## Copy all files into the docker image
COPY . /myip 


## Change the default directory to myip
WORKDIR /myip


## Install the reqrementes 
RUN python -m pip install -r requirements.txt


CMD ["/bin/sh", "-c", "python /myip/app.py"]