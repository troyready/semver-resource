#!/bin/bash
echo 'starting build...'
if [ -d "assets" ]; then
  rm -rf assets
fi
if [ -d "/tmp/semver-resource-build" ]; then
  rm -rf /tmp/semver-resource-build
fi
mkdir -p assets/assets
docker build -t semver-resource-builder .
# docker run -v assets:/assets semver-noanon
docker run -v /tmp:/hosttmp semver-resource-builder
cp -pr /tmp/semver-resource-build/* assets/assets
cd assets || exit
echo "FROM concourse/buildroot:base" > Dockerfile
echo "" >> Dockerfile
echo "ADD assets/ /opt/resource/" >> Dockerfile
docker build -t semver-resource .
