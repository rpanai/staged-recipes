#!/bin/bash

# Install to conda style directories
[[ -d lib64 ]] && mv lib64 lib

[[ ${target_platform} == "linux-64" ]] && targetsDir="targets/x86_64-linux"
[[ ${target_platform} == "linux-ppc64le" ]] && targetsDir="targets/ppc64le-linux"
[[ ${target_platform} == "linux-aarch64" ]] && targetsDir="targets/sbsa-linux"

for i in `ls`; do
    [[ $i == "build_env_setup.sh" ]] && continue
    [[ $i == "conda_build.sh" ]] && continue
    [[ $i == "metadata_conda_debug.yaml" ]] && continue
    if [[ $i == "include" ]]; then
        # Headers and libraries are installed to targetsDir
        mkdir -p ${PREFIX}/${targetsDir}
        mkdir -p ${PREFIX}/$i
        cp -rv $i ${PREFIX}/${targetsDir}
        # Header only component
    else
        # Put all other files in targetsDir
        mkdir -p ${PREFIX}/${targetsDir}/${PKG_NAME}
        cp -rv $i ${PREFIX}/${targetsDir}/${PKG_NAME}
    fi
done
