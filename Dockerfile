# define base image
FROM python:3.6-stretch

# use multiple key servers to protect against build failure
RUN set -x && \
    apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates \
    gettext-base \
    supervisor \
    apt-transport-https \
    apt-utils \
    locales

# Install Official Microsoft SQL Server Driver and ODBC
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y DEBIAN_FRONTEND=noninteractive apt-get install -y \
    msodbcsql17 \
    unixodbc-dev \
    && rm -rf /var/lib/apt/lists/* \
    # Adjust Locales to prevemt MS SQL Driver error
    && touch /usr/share/locale/locale.alias \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen

# set working directory
WORKDIR /jupyterlab_cerco/notebooks

COPY requirements.txt .

ENV TZ="America/Sao_Paulo"\
    JUPYTER_TOKEN="vert@2020"
	
# run command at build time
RUN pip install --no-cache-dir --disable-pip-version-check jupyterlab \
    && pip install --no-cache-dir --disable-pip-version-check -r requirements.txt \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \	
	&& echo $TZ > /etc/timezone	
	
EXPOSE 8888
CMD ["jupyter","lab","--ip=0.0.0.0", "--allow-root", "--no-browser"] #deploy jupyterlab	
