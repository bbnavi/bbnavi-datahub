#!/bin/sh

bundle exec rails runner "WasteNotification.new.send_notifications"
bundle exec rails runner "CleanUpService.new.perform"
bundle exec rake doorkeeper:db:cleanup
