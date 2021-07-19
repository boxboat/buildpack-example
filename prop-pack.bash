#!/usr/local/bin/bash


check_properties_field() {
  CONFIG=$1
  field=$2
  echo "---> Checking for required 'buildpack.properties' field: '$field'"
  if [ -z "${CONFIG["$field"]}" ] ; then
    echo "!--> ERROR: 'buildpack.properties' does not contain required field '$field'."
    echo "!--> ERROR: Make sure the required field is present and that 'buildpack.properties' ends with an empty line."
    exit 100
  fi
}


buildpack_from_properties() {
    declare -A CONFIG

    while IFS="=" read -r key value;
    do
      CONFIG[$key]=$value
    done < buildpack.properties
    unset IFS

    check_properties_field "$CONFIG" "image"
    check_properties_field "$CONFIG" "command"

    echo "---> Building application image ${CONFIG["image"]}"
    img="${CONFIG["image"]}"
    cmd="${CONFIG["command"]}"

    pack build "k3d-myregistry.localhost:12345/$img:local" --builder=gcr.io/buildpacks/builder:v1 --env=GOOGLE_ENTRYPOINT="$cmd" --path=.
    docker push "k3d-myregistry.localhost:12345/$img:local"
}


# $1 Array of relative paths to project sources
micro_svc_builder() {
  web_service_sources=($@)
  base_dir=$(pwd)

  echo "---> Starting Buildpack proccess"
  for src in "${web_service_sources[@]}"; do

    full_src_dir="$base_dir/$src"
    cd "$src" || exit

    if [[ ! -f ./buildpack.properties ]]; then
      echo "!--> ERROR: Did not find 'buildpack.properties' file in source directory $full_src_dir"
      exit 100
    fi

    echo "---> Performing setup for project directory $full_src_dir"
    buildpack_from_properties

    cd "$base_dir" || exit

  done
}


micro_svc_builder "$@"