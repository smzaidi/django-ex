#FROM docker-registry.webplatformsunpublished.umich.edu/openshift/python:2.7
FROM python:2.7
MAINTAINER Chris Kretler "ckretler@umich.edu"

USER root

RUN yum -y update

WORKDIR /app

COPY . .

RUN . /opt/app-root/etc/scl_enable \
	&& pip install -r requirements.txt

#RUN chown -R www-data /app
#USER www-data
RUN chmod g+r -R wsgi.py ./welcome

EXPOSE 8000

USER nobody

CMD ["gunicorn", "-c", "guniconf", "wsgi:application"]
