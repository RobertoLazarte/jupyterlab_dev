# define base image
FROM python:3.6

# set working directory
WORKDIR /jupyterlab_cerco/notebooks

COPY requirements.txt .

ENV TZ="America/Sao_Paulo" #\
    #JUPYTER_TOKEN="vert@2020"

# install FreeTDS and dependencies
RUN apt-get update \
 && apt-get install unixodbc -y \
 && apt-get install unixodbc-dev -y \
 && apt-get install freetds-dev -y \
 && apt-get install freetds-bin -y \
 && apt-get install tdsodbc -y \
 && apt-get install --reinstall build-essential -y

# populate "ocbcinst.ini"
RUN echo "[FreeTDS]\n\
Description = FreeTDS unixODBC Driver\n\
Driver = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so\n\
Setup = /usr/lib/x86_64-linux-gnu/odbc/libtdsS.so" >> /etc/odbcinst.ini

# run command at build time
RUN pip install jupyterlab \
    && pip install -r requirements.txt \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \	
	&& echo $TZ > /etc/timezone	

EXPOSE 8888
CMD ["jupyter","lab","--ip=0.0.0.0", "--allow-root", "--no-browser"] #deploy jupyterlab