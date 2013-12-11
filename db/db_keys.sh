#!/bin/bash
env=$1
if [ "x$env" != "x" ]; then
  env="$env":
fi
namespace="nyhetis:db:"$env

echo "number of relevant news:" $namespace"news:all" 
redis-cli KEYS $namespace"news:all" | xargs redis-cli SCARD

echo "bag of words: ${namespace}bagwords:words" 
redis-cli KEYS "${namespace}bagwords:words" | xargs redis-cli SMEMBERS
