# Victron Eastron SDM630 Bridge


This small program emulates the Energy Meter in a Victron ESS System. It reads
values from an existing MQTT Broker (in my case MBMD) and publishes the
result on dbus as if it were the SDM630 meter.

![Victron Overview](./.media/victron_meter.png)

Use this at your own risk, I have no association with Victron or Eastron
and am providing this for anyone who already has these components and
wants to play around with this.

I use this privately, and it works in my timezone, your results may vary.

Special Thanks to Sean (mitchese) who did most of the work for the shm-et340.
Mostly of the code is forked from his repo. You can find here:
[Repo](https://github.com/mitchese/shm-et340)

# Setup

## Install MBMD

To load the data from the EASTRON power meter into your MQTT Broker,
please use the mbmd program. You can find more information here:

[Volkzaehler/mbmd](https://github.com/volkszaehler/mbmd)

![MBMD Frontend](./.media/mbmd.png)

Here is an example of how the SDM630 data looks in the broker:

![MQTT-Topics](./.media/mqtt-topics.png)

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

## Copy the file to you Venus OS (CerboGX)

        scp ./bin/main-linux-arm/sdm630-bridge root@CerboGX

## Start the program

Login in via ssh to your Venus Device:

        ssh root@CerboGX

Start the program:

        ./sdm630-bridge

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
