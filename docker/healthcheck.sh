#!/usr/bin/env ash
if [ -z "${PORT}" ]; then
    PORT="8080"
fi
if ! curl -f "http://localhost:${PORT}/api/system_health"; then
    exit $?
fi
