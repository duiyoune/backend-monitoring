SENTRY_AUTH_TOKEN=5d0457967dd6445990de01870c94d77bf11189ff773249218399f02f44edc6e5
SENTRY_ORG=tongji-university-sz
SENTRY_PROJECT=django
VERSION=`sentry-cli releases propose-version`

deploy: install create_release associate_commits run_django

install:
	pip install -r ./requirements.txt

create_release:
	sentry-cli releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(VERSION)

associate_commits:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) \
		set-commits $(VERSION) --auto

run_django:
	VERSION=$(VERSION) python manage.py runserver
