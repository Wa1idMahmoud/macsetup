# Function to print an exit message and then exit
# Parameters:
#   $1 - Message
#   $2 - Exit code
exit_msg() {
  local message=$1
  local exit_code=$2
  echo -e "$message"
  exit $exit_code
}

# Function to check the number of arguments passed into the script
# Parameters:
#   $1 - Number of arguments given
#   $2 - Number of expected arguments
argument_checker() {
  local given=$1
  local expected=$2
  if [ $given -ne $expected ]; then
    exit_msg "Invalid number of arguments. Expected $expected, got $given." 1
  fi
}
