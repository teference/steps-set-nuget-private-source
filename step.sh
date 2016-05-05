#!/bin/bash

# exit if a command fails
set -e

# Required parameters
if [ -z "${nuget_source_name}" ] ; then
  echo " [!] Missing required input: nuget_source_name"
  exit 1
fi

if [ -z "${nuget_source_path_or_url}" ] ; then
  echo " [!] Missing required input: nuget_source_path_or_url"
  exit 1
fi

if [ ! -z "${nuget_source_username}" ] && [ -z "${nuget_source_password}" ] ; then
  echo " [!] Both UserName and Password for NuGet private source has to be specified or leave both empty!"
  exit 1
fi

if [ -z "${nuget_source_username}" ] && [ ! -z "${nuget_source_password}" ] ; then
  echo " [!] Both UserName and Password for NuGet private source has to be specified or leave both empty!"
  exit 1
fi

echo ""

# ---------------------
# --- Configs:

echo " (i) Provided NuGet private source name: ${nuget_source_name}"
echo " (i) Provided NuGet private source path / url: ${nuget_source_path_or_url}"

if [ ! -z "${nuget_source_username}" ] ; then
  echo " (i) Provided UserName for connecting to an authenticated NuGet private source: ${nuget_source_username}"
fi

if [ ! -z "${nuget_source_password}" ] ; then
  echo " (i) Password for connecting to an authenticated NuGet private source was provided. Not logged for security reasons"
fi

# ---------------------
# --- Main:

# verbose / debug print commands
set -v

# Nuget private source add
nuget="/Library/Frameworks/Mono.framework/Versions/Current/bin/nuget"

echo ""
echo ""
echo " (i) Adding provided NuGet private source..."

if [ ! -z "${nuget_source_username}" ] && [ ! -z "${nuget_source_password}" ] ; then
  "${nuget}" sources add -Name "${nuget_source_name}" -Source "${nuget_source_path_or_url}" -UserName "${nuget_source_username}" -Password "${nuget_source_password}" -Verbosity "detailed"
fi

if [ -z "${nuget_source_username}" ] && [ -z "${nuget_source_password}" ] ; then
  "${nuget}" sources add -Name "${nuget_source_name}" -Source "${nuget_source_path_or_url}" -Verbosity "detailed"
fi

echo "Provided NuGet private source added successfully!"
