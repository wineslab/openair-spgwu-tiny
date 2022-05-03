#!/bin/bash


build_spgwu() {
cd build/scripts
./build_spgwu --build-type Debug --jobs --Verbose
#    ldd /openair-spgwu-tiny/build/spgw_u/build/spgwu && \
cp ../spgw_u/build/spgwu ../spgw_u/build/oai_spgwu
cd ../../
echo "build done"
}

push_bin_file() {
echo "Running target container..."
#docker run --rm --name temp_container --entrypoint bash oai-spgwu-debug:debug
docker create --name temp_container oai-spgwu-debug:debug
echo "Copying files..."
docker cp ./build/spgw_u/build/oai_spgwu temp_container:/openair-spgwu-tiny/bin
echo "Committing back to image..."
docker commit temp_container oai-spgwu-debug:debug
docker rm temp_container
echo "Done"
}

echo "Do you wish to install the dependencies?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) apt remove -y libbost*; ./build/scripts/build_spgwu -I -f; break;;
        No ) break;;
    esac
done

echo "Do you wish to build spgwu?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) build_spgwu; break;;
        No ) break;;
    esac
done

echo "Do you wish to push the bin files?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) push_bin_file; break;;
        No ) break;;
    esac
done
