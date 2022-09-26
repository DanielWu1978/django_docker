FROM python:3.10.7-alpine3.16

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY . .

EXPOSE 8080
CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
