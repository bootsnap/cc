#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install --deployment
bin/rails assets:precompile
bin/rails assets:clean
bin/rails db:migrate 
bin/rails db:seed
bin/rake spree_sample:load