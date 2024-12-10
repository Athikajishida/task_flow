#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Run database migrations (add this in the build script for free plans)
bundle exec rails db:migrate

# Precompile assets (skip this if you're API-only and don't have frontend assets)
# bundle exec rails assets:precompile
# bundle exec rails assets:clean
