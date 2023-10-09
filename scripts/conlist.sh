#!/bin/bash

# Import utility functions
source bashutils.sh

# Temporary files to hold container information
tmp_conlist="/tmp/conlist.txt"
tmp_conliststripped="/tmp/conliststripped.txt"

# Function to get logs for specific containers within a pod
getContainerLogs(){
  # Define local variables based on the function's parameters
  local pod=$1
  local containerName=$2
  local logs_opt=$3

  # Show logs header
  echo "-----------------logs-------------------------"

  # Depending on the option, either follow logs or get a snapshot
  if [ "$logs_opt" == "follow" ]; then
    kubectl logs -f "${pod}" -c "${containerName}"
  else
    kubectl logs --tail="${logs_opt}" "${pod}" -c "${containerName}"
  fi

  # Show logs footer
  echo "---------------logs end-----------------------"
  echo
}

# Function to get a list of containers and their statuses within a pod
getContainers() {
  # Define container types and their corresponding jq JSON paths
  containerTypes=("InitContainers,.status.initContainerStatuses[]" "Containers,.status.containerStatuses[]")

  # Loop through each container type to get its details
  for containerType in "${containerTypes[@]}"
  do
    # Split the containerType string into listTitle and jsonRequest
    IFS=, read -r listTitle jsonRequest <<< "${containerType}"

    # Use jq to extract container details and store them in a temporary list
    echo '[' > $tmp_conlist
    kubectl get pods "${1}" -o json | jq "${jsonRequest}" | jq '.' >> $tmp_conlist
    echo ']' >> $tmp_conlist

    # Use sed to clean up the JSON format
    sed -z -i 's/}\n{/},\n{/g' $tmp_conlist

    # Parse the cleaned JSON to get the desired fields
    jq '.[] | [.name, .ready, [.state | keys]]' $tmp_conlist > $tmp_conliststripped

    # Further format the parsed output to be read into an array
    sed -z -i -e 's|\]\n\[|'#'|g' \
        -e 's|\[||g'              \
        -e 's|\]||g'              \
        -e 's|\n||g'              \
        -e 's| ||g'               \
        -e 's|#| |g'              \
        -e 's|,|.|g'              \
        -e 's|"||g'               \
        $tmp_conliststripped

    # Read the formatted output into an array
    contArray=($(cat $tmp_conliststripped))

    # Display container info header
    echo -e "\n${GREEN}${listTitle} (${#contArray[@]}):${NC}"

    # Loop through each container and display its details
    for container in "${contArray[@]}"
    do
        IFS=. read -r contName contReady contStatus <<< "${container}"
        printContainerInfo "${contName}" "${contReady}" "${contStatus}"
    done

    # Clean up temporary files
    rm $tmp_conlist
    rm $tmp_conliststripped
  done
}

# Function to display individual container information
printContainerInfo() {
  local containerName=$1
  local containerReady=$2
  local containerStatus=$3
  local containerPrintLine=""

  # Determine the color code for the container status
  case $containerStatus in
     running)
       containerPrintLine="- ${containerName} (Status: ${GREEN}${containerStatus}${NC}"
       ;;
     terminated)
       containerPrintLine="- ${containerName} (Status: ${RED}${containerStatus}${NC}"
       ;;
     *)
       containerPrintLine="- ${containerName} (Status: ${YELLOW}${containerStatus}${NC}"
       ;;
  esac

  # Determine the readiness of the container
  if [[ "${containerReady}" == 'false' ]]
  then
    containerPrintLine+="${RED} - not ready!${NC})"
  else
    containerPrintLine+=")"
  fi

  # Print the final line for the container
  echo -e "${containerPrintLine}"
}

# Function to color-code the Pod status.
# Parameter 1: Pod Status.
colourCodePodStatus() {
  local podStatusIn=$1

  # Use color codes to represent the pod status
  case $podStatusIn in
    Running | Completed)
      ccPodStatus="${NC}(Status: ${GREEN}${podStatusIn}${NC})"
      ;;
    Error | Init:CrashLoopBackOff)
      ccPodStatus="${NC}(Status: ${RED}${podStatusIn}${NC})"
      ;;
    *)
      ccPodStatus="${NC}(Status: ${YELLOW}${podStatusIn}${NC})"
      ;;
  esac
}

# Main Script Start

# Display script header
echo -e "\n${GREEN}Pod Container Lister${NC}"

# Check for valid arguments; 'argument_checker' function should be in 'bashutils.sh'
argument_checker $# 1

# Indicate the pod name pattern being searched for
echo -e "\n${CYAN}Searching for pods matching: ${YELLOW}${1}${NC}"

# Fetch pod names and statuses, and filter based on input
inputPod=$(kubectl get pods | awk '{print $1"."$3}' | grep "${1}" | cut -d ' ' -f 1)

# Exit if no pods are found
if [[ -z $inputPod ]]
then
  exit_msg "No pods found with the name $1" 1
fi

# Create an array of found pods
podArray=($inputPod)

# Handle cases where multiple matching pods are found
if [[ ${#podArray[@]} -gt 1 ]]
then
  echo "Multiple matching pods found. Please choose pod..."
  i=1
  for pod in "${podArray[@]}"
  do
    IFS=. read -r podName podStatus <<< "${pod}"
    colourCodePodStatus "${podStatus}"
    echo -e "${YELLOW}${i}${NC}: ${GREEN}${podName} ${ccPodStatus}"
    ((i=i+1))
  done

  # Prompt user to choose a pod
  IFS= read -e -p "Pod number to get containers for: " option

  # Validate user input
  if [[ $option == 0 || $option > ${#podArray[@]} || ! ($option =~ ^[0-9]+$) ]]
  then
      exit_msg "Invalid option." 1
  fi
  IFS='.' read -r targetPod targetPodStatus <<< "${podArray[$option -1]}"
else
  IFS='.' read -r targetPod targetPodStatus <<< "${inputPod}"
fi

# Display the selected pod and its status
colourCodePodStatus "${targetPodStatus}"
echo -e "\n${CYAN}Getting containers from pod: ${YELLOW}${targetPod}${NC} ${ccPodStatus}"

# Get and display container information for the selected pod
getContainers "${targetPod}"

# Prompt for logs
while IFS= read -r -p "Get logs for a container? <ContainerName> or leave empty for no: " cont_name; do
  [[ $cont_name ]] || break  # exit loop if input is empty
  IFS= read -r -p "How many logs would you like? <Number of lines (default 10)> || <'follow'> to stream logs: "  log_opt;
  getContainerLogs "${targetPod}" "${cont_name}" "${log_opt}"
  getContainers "${targetPod}" "${2}"
done

# Script Completion Message
echo
exit_msg "Done." 0
