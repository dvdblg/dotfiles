#!/bin/sh

inputDevicesInfoFilePath ()
{
    echo "/proc/bus/input/devices"
}


inputDevicesInfo ()
{
    cat $(inputDevicesInfoFilePath)
}

# arguments: device name, file line prefix
inputDeviceValue ()
{
    # constants
    local INFO_FILE=$(inputDevicesInfoFilePath)
    local NAME_PREFIX="N: Name="

    # name the function arguments
    local devName=$1
    local linePrefix=$2 

    # find the line number in the info file containing 
    # both the name prefix and device name argument 
    local lnNo=$(grep -n "${NAME_PREFIX}" ${INFO_FILE} | grep ${devName} | head -n1 | cut -d: -f1)

    # starting from the line number previously determined,
    # find the first line which contains the prefix argument
    # and extract the value token from that line
    local value=$(tail +${lnNo} ${INFO_FILE} | grep "${linePrefix}" | head -n1 | cut -d= -f2)

    # "return" the value via an echo  
    # if no value was found, don't echo anything 
    # but (literally) return an error code 
    if [ -z "${value}" ] ; then return 1; fi;
    echo ${value}
}

# arguments: device name
inputDevicePhys ()
{
    echo $(inputDeviceValue $1 "P: Phys=")
}

# arguments: device name
inputDeviceSysfs ()
{
    echo $(inputDeviceValue $1 "S: Sysfs=")
}

# arguments: device name
inputDeviceHandlers ()
{
    echo $(inputDeviceValue $1 "H: Handlers=")
}

# arguments: device name
inputDeviceEventHandlerPath ()
{
   # constants
    local INPUT_DEVICE_DIR_PATH="/dev/input/"

    # get the handlers for the device (as a space delimited list) 
    # if nothing is found return error code 1 and don't echo anything
    local handlers=$(inputDeviceHandlers $1)
    if [ -z "${handlers}" ] ; then return 1; fi;

    # interate through the list (splits on white space implictly)
    for handler in ${handlers}
    do
        # if the handler starts with "event", then echo the path 
        # and return from the function successfully 
        case ${handler} in event*)
            echo ${INPUT_DEVICE_DIR_PATH}${handler}  
            return
        esac
    done

    # if no event handler was found, don't echo anything 
    # but (literally) return an error code 
    return 1
}

inputDeviceEventHandlerPath $1
