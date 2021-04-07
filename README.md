# Victron SDM630 Bridge

This small program emulates the SDM630 Energy Meter in a Victron ESS System. It reads
values from an existing MBMD and publishes the result on dbus as
if it were the SDM630 meter.

Use this at your own risk, I have no association with Victron or Eastron and am providing
this for anyone who already has these components and wants to play around with this.

I use this privately, and it works in my timezone, your results may vary

Special Thanks to Sean (mitchese) who did most of the work for the shm-et340.
[Repo](https://github.com/mitchese/shm-et340)


# Setup

# Compiling from source

To compile this for the Venus GX (an Arm 7 processor), you can easily cross-compile with the following:

`GOOS=linux GOARCH=arm GOARM=7 go build`


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
