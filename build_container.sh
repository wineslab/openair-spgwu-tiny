#!/bin/bash
echo "Install dependencies in the spgwu builder container? (yes if first time run)"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) docker build --target oai-spgwu-debug --tag oai-spgwu-debug:debug --file ./docker/Dockerfile.ubuntu18.04 .; break;;
        No ) docker build --rm --target oai-spgwu-debug --tag oai-spgwu-debug:debug --file ./docker/Dockerfile.ubuntu18.04.no_dependences .; break;;
    esac
done

