change_python() {
  oldVersion=$(python --version)
  newVersion=$1

  sudo rm /usr/bin/python 
  sudo ln -s /usr/bin/python$newVersion /usr/bin/python
  sudo ln -s /usr/bin/python$newVersion /usr/bin/py

  updated=$(python --version)
  echo "Old: $oldVersion"
  echo "New:  New: $updated"
}
