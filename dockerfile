FROM python:3.9-slim
WORKDIR /Dashboard
ADD dash_requirements.txt .
ADD Dashboard .

RUN apt-get -y update && apt-get install -y curl gnupg

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

RUN curl https://packages.microsoft.com/config/debian/11/prod.list  \
    > /etc/apt/sources.list.d/mssql-release.list

RUN exit
RUN apt-get -y update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql18
RUN pip install -r dash_requirements.txt
EXPOSE 5000
CMD ["python","myindex.py","--host=0.0.0.0"]