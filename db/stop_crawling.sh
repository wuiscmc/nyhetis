#!/bin/bash
env=$1
if [ "x$env" != "x" ]; then
    env="$env":
fi
namespace="nyhetis:db:"$env
redis-cli KEYS $namespace"crawler:crawling" | xargs redis-cli DEL