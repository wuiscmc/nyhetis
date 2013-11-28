#!/bin/bash

echo "number of relevant news"
redis-cli KEYS "nyhetis:db:news:all" | xargs redis-cli SCARD

echo "bag of words"
redis-cli KEYS "nyhetis:db:bagwords:words" | xargs redis-cli SMEMBERS
