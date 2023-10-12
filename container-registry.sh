#!/bin/bash

# * repository name in docker hub
REPOSITORY=""

# * image version/tag
VERSION="latest"

# * folder where the dockerfile is located
PATH_DOCKERFILE=""

# * array containing the name of the images
IMAGES=("")

# * function to build images
function build() {
    cd "../.."
    for image in ${IMAGES[@]}; do
        echo -e "\nBuilding Image: ${image} ...\n"
        docker build . --target $image -t "${REPOSITORY}/${image}:${VERSION}" -f $PATH_DOCKERFILE
    done
}

# * function to upload images to docker hub
function push() {
    for image in ${IMAGES[@]}; do
        echo -e "\nPushing Image: ${image} ...\n"
        docker push "${REPOSITORY}/${image}:${VERSION}"
    done
}

# * Main function that executes the build and push functions if no parameters are entered, otherwise it is possible to choose between the build and push options
# *     examples:
# *         sh container-registry.sh // executes the build and push functions
# *         sh container-registry.sh build // only executes the build function
# *         sh container-registry.sh push // only executes the push function
function start() {
    if [ -z $@ ]; then
        build
        push
    else
        $1
        $2
    fi
}

start $@
