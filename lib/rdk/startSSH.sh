#!/bin/sh
##########################################################################
# If not stated otherwise in this file or this component's Licenses.txt
# file the following copyright and licenses apply:
#
# Copyright 2017 RDK Management
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################

WAN_INTERFACE=eth0

loop=1

while [ $loop -eq 1 ]
      do
           # check for interface
           ret=`ifconfig | grep $WAN_INTERFACE | grep -v $WAN_INTERFACE:0`
           if [ "$ret" ]; then
                # check for IP address
	   ipAddress=`ifconfig $WAN_INTERFACE |  grep inet | grep -v localhost | grep -v 127.0.0.1 |tr -s ' ' | cut -d ' ' -f3 | sed -e 's/addr://g'`
                if [ "$ipAddress" ]; then
                       echo "ipAddress: $ipAddress"
                       loop=0
                else
                       sleep 5
                fi
           else
                sleep 5
           fi
      done
echo --------- $interface got an ip $ipAddress starting dropbear service ---------
dropbear -b /etc/sshbanner.txt -a -p $ipAddress:22 &

