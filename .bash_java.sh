j() {
  javac $1.java && java $1
}

jcd() {
  current_directy=$(pwd)
  # TODO: find out if src is always the folder desctination
  folder_destination="./src"
  class_name=$1

  cd $folder_destination
  javac $class_name.java && java $class_name
  cd $current_directy
}
