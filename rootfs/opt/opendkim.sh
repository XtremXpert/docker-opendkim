#!/bin/bash
exec opendkim -f -x /etc/opendkim.conf -p inet:12301@0.0.0.0
