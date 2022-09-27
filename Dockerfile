FROM python:3.10.7-alpine3.16
RUN mkdir -p /app/danielsite
COPY requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt
COPY danielsite /app
RUN ls --recursive /pp
WORKDIR /app

ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
