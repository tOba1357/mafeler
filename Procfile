web:  bin/rails server -p $PORT -e $RAILS_ENV
worker: bundle exec sidekiq -c ${SIDEKIQ_CONCURRENCY:-5}
