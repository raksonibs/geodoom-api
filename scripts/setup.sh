#!/bin/bash

if [[ $# -eq 0 ]]; then
    echo 'missing environment: development, staging or production'
    exit 0
fi

RAILS_ENV=$1 bundle exec rake db:seeds
RAILS_ENV=$1 bundle exec rake create_battles