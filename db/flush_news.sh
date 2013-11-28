#!/bin/bash

redis-cli KEYS "nyhetis:db:news:*" | xargs redis-cli DEL