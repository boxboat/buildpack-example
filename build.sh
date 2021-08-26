#!/usr/local/bin/bash


build_and_push() {
    img=$(grep '^id\s*=' ./project.toml | sed 's/^.*"\([^"]*\)".*$/\1/')

    pack build "127.0.0.1:12345/$img:local" --builder=gcr.io/buildpacks/builder:v1  --path=.
    docker push "127.0.0.1:12345/$img:local"
}


# $1 Array of relative paths to project sources
micro_svc_builder() {
  web_service_sources=($@)
  base_dir=$(pwd)

  echo "---> Starting Buildpack proccess"
  for src in "${web_service_sources[@]}"; do

    full_src_dir="$base_dir/$src"
    cd "$src" || exit

    if [[ ! -f ./project.toml ]]; then
      echo "!--> ERROR: Did not find 'project.toml' file in source directory $full_src_dir"
      exit 100
    fi

    echo "---> Performing setup for project directory $full_src_dir"
    build_and_push

    cd "$base_dir" || exit

  done
}


micro_svc_builder "$@"
