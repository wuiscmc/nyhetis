#!/bin/bash
env=$1
if [ "x$env" != "x" ]; then
    env="$env":
fi
namespace="nyhetis:db:"$env
redis-cli KEYS $namespace"news:all" | xargs redis-cli DEL
redis-cli KEYS $namespace"news:*" | xargs redis-cli DEL
