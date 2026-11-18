#!/bin/sh
set -e
./upgrade-dotnet.sh
./upgrade-nugets.sh
./upgrade-actions.sh
