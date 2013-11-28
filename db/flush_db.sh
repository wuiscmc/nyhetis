#!/bin/bash

redis-cli KEYS "nyhetis:db:*" | xargs redis-cli DEL