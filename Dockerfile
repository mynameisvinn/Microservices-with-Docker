FROM dataquestio/python3-starter

WORKDIR /todo

# placing requirements first allows docker caching http://justanr.github.io/mistakes-when-dockerizing-python-apps
COPY requirements.txt /todo
RUN pip install --user -r requirements.txt

ADD . /todo
