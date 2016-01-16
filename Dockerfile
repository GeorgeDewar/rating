FROM ruby:2.3.0-onbuild

ENV RAILS_ENV=production

EXPOSE 9292
CMD puma
