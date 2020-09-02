# heartbeat.sh
A shell script client for [heartbeat.sh](https://heartbeat.sh)

## Usage
To set up the environment for the heartbeat script, run `source setup.sh {your-subdomain}`. You might want to add this line to your profile.

If you've run the setup, you can send heartbeats to heartbeat.sh with `./heartbeat.sh name [warning-timeout] [error-timeout]`.

Please note:
- The name is treated as a unique identifier. Sending a heartbeat to a non-existing name will create it.
- The first timeout specified is always treated as the warning timeout.
- The timeout format is `[1d][1h][1m][1[s]]`. You can replace `1` with any integer.
- The specified days, hours, and minutes always get converted to seconds. The conversion is not aware of timezones or leap seconds.
- The conversion algorithm is pretty lenient. `1d`, `1D`, `1days`, `1DaYes`, and `1doggo` will all be converted to 86400 seconds.
- If no timeouts are specified, the warning timeout will default to 1 minute for new heartbeats, or the exisiting timeout for existing heartbeats.
- If only the warning is specified, the error timeout will default to 5 times the warning timeout for new heartbeats, or the existing timeout for exisiting heartbeats.
