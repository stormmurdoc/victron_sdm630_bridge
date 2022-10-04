# Victron Eastron SDM630 Bridge (Alternative to the EM24)

This small program emulates the Energy Meter (EM24) in a Victron ESS System. It reads
values from an existing MQTT Broker (in my case MBMD) and publishes the
result on dbus as if it were the SDM630 meter.

![Victron Overview](./.media/victron_meter.png)

Use this at your own risk, I have no association with Victron or Eastron
and am providing this for anyone who already has these components and
wants to play around with this.

I use this privately, and it works in my timezone, your results may vary.

__Update:__ Having owned a Multiplus II now, I can confirm that it works flawlessly with the ESS!

Special Thanks to Sean (mitchese) who did most of the work for the shm-et340.
Mostly of the code is forked from his repo. You can find it here:
[Repo](https://github.com/mitchese/shm-et340)

# Tested Venus OS Version

* 18.03.2022    v2.84

# Setup

## Install MBMD

To load the data from the EASTRON power meter into your MQTT Broker,
please use the mbmd program. You can find more information here:

[Volkzaehler/mbmd](https://github.com/volkszaehler/mbmd)

![MBMD Frontend](./.media/mbmd.png)

Here is an example of how the SDM630 data looks in the broker:

![MQTT-Topics](./.media/mqtt-topics.png)

VRM Portal

![Victron VRM Portal](./.media/vrm_portal.png)

# Configuration

## Change Default Configuration

You need to change the default values in the ./sdm630-bridge.go file:

            BROKER      = "192.168.1.119"
            PORT        = 1883
            TOPIC       = "stromzaehler/#"
            CLIENT_ID   = "sdm630-bridge"


## Compiling from source

To compile this for the Venus GX (an Arm 7 processor), you can easily cross-compile with the following:

        `GOOS=linux GOARCH=arm GOARM=7 go build`

You can compile it also with the make command:

        make compile

## Copy the file to your Venus OS device (e.g. CerboGX)

        scp ./bin/main-linux-arm/sdm630-bridge root@CerboGX

## Start the program

Login in via ssh to your Venus Device:

        ssh root@CerboGX

Start the program:

        ./sdm630-bridge

# Autostart Venus OS

The only directory that is unaffected by an update is the /data directory.
Fortunately, the root directory can also be found (under /data/home/root).
If there is an executable file with the name rc.local, it will be executed
when the system is started. This makes it possible to start the
sdm630-bridge automatically.

## Create rc.local file

Login into the system via ssh. Create a file with the following command:

        vi /data/rc.local

Add the following content:

        #!/bin/bash
		sleep 20 && /data/home/root/startup.sh > /data/home/root/sdm630-bdrige.log 2>&1 &

Save the file and make them executable:

        chmod +x /data/rc.local

## Create the startup script

		cd /data/home/
		vi startup.sh

Paste the following content into the startup script:

        #!/bin/sh
		while true; do
		  /data/home/root/sdm630-bridge
		  sleep 1
		done

Save the file and make them executable:

    chmod +x /data/home/startup.sh

Reboot the system and check if the process come up.

        ps | grep sdm630

# Victron Grid Meter Values

[Source Victron](https://github.com/victronenergy/venus/wiki/dbus#grid-meter)

        com.victronenergy.grid

        /Ac/Energy/Forward     <- kWh  - bought energy (total of all phases)
        /Ac/Energy/Reverse     <- kWh  - sold energy (total of all phases)
        /Ac/Power              <- W    - total of all phases, real power

        /Ac/Current            <- A AC - Deprecated
        /Ac/Voltage            <- V AC - Deprecated

        /Ac/L1/Current         <- A AC
        /Ac/L1/Energy/Forward  <- kWh  - bought
        /Ac/L1/Energy/Reverse  <- kWh  - sold
        /Ac/L1/Power           <- W, real power
        /Ac/L1/Voltage         <- V AC
        /Ac/L2/*               <- same as L1
        /Ac/L3/*               <- same as L1
        /DeviceType
        /ErrorCode

# Todo

- [ ] Check Update process -> https://www.victronenergy.com/live/ccgx:root_access

