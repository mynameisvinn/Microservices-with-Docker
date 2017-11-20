FROM dataquestio/python3-starter
ADD . /todo
WORKDIR /todo

# include "--user" since containers are not sudo
RUN pip install --user -r requirements.txt