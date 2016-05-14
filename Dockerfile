FROM python:2-alpine

RUN apk update && apk upgrade
RUN apk add --update curl-dev gcc musl-dev libffi-dev build-base python-dev jpeg-dev zlib-dev
    && rm -f /var/cache/apk/*
    && apk del build-dependencies

ENV LIBRARY_PATH=/lib:/usr/lib
ENV WWW_PATH /opt/www
ENV CONFIG_FILE_PATH /etc/minos

RUN mkdir -p ${WWW_PATH}
RUN mkdir ${CONFIG_FILE_PATH}
WORKDIR ${WWW_PATH}

COPY . ${WWW_PATH}

RUN pip install virtualenv
RUN virtualenv /env && /env/bin/pip install -r requirements.txt

VOLUME ["/etc/minos"]
EXPOSE 8080
CMD ["/env/bin/python", "main.py", "--port=8080", "--url=http://minos.leavesongs.com", "--config=/etc/minos/config.yaml"]