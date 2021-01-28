#!/bin/bash

set -eu
set -o pipefail

terraform output instance_public_ips \
          | grep "\." | head -n 1 | tr -d '" ,'