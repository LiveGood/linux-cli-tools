

# 1. Creates a container from image "docker run"
# 2. With interactive terminal options "-it"
# 3. Runs in daemon mode(in background) "-d"
# 4. Mounts a volume "-v"
# 5. Mounts the current directory in the container dirctory after :  "$PWD:/bitnami/mongodb/data/db"
# 6. Exports port on host:container "-p 27018:207017"
# 7. Name of the new container "--name test-mongo"
# 8. Name of the image to use "172888/intelrx-full-mongodb"

# docker create  persitant container with volume from image
# d => docker
# c => container
# p => persitent
dcp() {
  host_directory=$1  
  container_directory=$2
  ports_map=$3
  new_container_name=$4
  image_name=$5

  # docker run -it -d -v $PWD:/bitnami/mongodb/data/db -p 27018:207017 --name test-mongo 172888/intelrx-full-mongodb
  docker run -it -d -v $host_directory:$container_directory -p $ports_map --name $new_container_name $image_name

  # USE:
  # dcp $PWD /bitnami/mongodb/data/db 27018:207017 test-mongo 172888/intelrx-full-mongodb
}
