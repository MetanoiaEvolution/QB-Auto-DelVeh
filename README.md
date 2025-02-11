# Vehicle Cleanup Script for FiveM

This script automatically cleans up unused vehicles in FiveM based on certain conditions, such as whether the vehicle is unlocked, if it's an NPC vehicle, and more. It also includes manual vehicle cleanup via a command with customizable radius and countdown notifications.

## Features

- **Automatic Cleanup**: Periodically deletes NPC vehicles or player vehicles that are unlocked and unoccupied.
- **Manual Cleanup**: Allows players to manually clean up vehicles within a specified radius.
- **Countdown Notifications**: Sends notifications to players 60 seconds, 30 seconds, and 10 seconds before cleanup.
- **Excluded Vehicles**:
    - Locked player vehicles.
    - Vehicles being driven or occupied by players.
    - Vehicles already taken by players (local or NPC).

## Installation

1. Download the script and place it in your `resources` directory on your server.
2. Add the following line to your `server.cfg`:
 ```plaintext
   start vehicle_cleanup
```
3. Customize the settings in the config.lua file:
   - CleanupInterval: Set the automatic cleanup interval in minutes.
   - CleanupRadius: Set the radius for the manual cleanup command.
   - CleanupMessage: Customize the message that will be sent after cleanup.

## Configuration
Edit the config.lua file to adjust the following parameters:
 ```plaintext
Config = {
    -- Interval for automatic vehicle cleanup (in minutes)
    CleanupInterval = 10, 
    
    -- Default cleanup radius (in meters) for manual cleanup command
    CleanupRadius = 100,

    -- The message sent after cleanup
    CleanupMessage = "✅ Unused vehicles have been removed!",
}
```
## Breakdown of Configuration Options:
- CleanupInterval:

  - Sets the interval (in minutes) for the automatic vehicle cleanup.
  - Example: CleanupInterval = 10 means the cleanup will occur every 10 minutes.

- CleanupRadius:
  - Defines the radius (in meters) within which vehicles will be cleaned up during manual cleanup using the /scrapnow [radius] command.
  - Example: CleanupRadius = 100 means the manual cleanup will target vehicles within a 100-meter radius of the player who issued the command.
- CleanupMessage:
  - Customizes the message sent to all players after the cleanup process.
  - Example: CleanupMessage = "✅ Unused vehicles have been removed!" is the default message that will be shown after the cleanup finishes.

## Commands
- /scrapnow [radius] - Triggers manual vehicle cleanup. You can specify the radius in meters. If no radius is provided, it defaults to the radius defined in config.lua. A 10-second countdown will be shown before the cleanup happens.

## Example Usage
1. Automatic Cleanup:
  - The script will automatically delete unused vehicles based on the interval defined in CleanupInterval.
2. Manual Cleanup:
  - To delete vehicles within a 200-meter radius:
 ```plaintext
/scrapnow 200
```
  - The system will notify all players and start the cleanup with a 10-second countdown.

## Notifications
The script will notify players as follows:
- 60 seconds:
  - ⚠️ Vehicle cleanup in 60 seconds!
- 30 seconds:
  - ⚠️ Vehicle cleanup in 30 seconds!
- 10 seconds:
  - ⚠️ Vehicle cleanup in 10 seconds!
- Manual Cleanup:
  - Countdown notifications at 5 seconds, 1 second, and final cleanup notification.

## How It Works
- Automatic Cleanup: Periodically checks for NPC vehicles, unlocked player vehicles that are unoccupied, and NPC vehicles that are unoccupied.

- Manual Cleanup: The cleanup process can be triggered with a specified radius. The system will notify all players of the countdown before the cleanup process is executed.

## License
This script is provided as-is and can be used freely for FiveM servers. No warranty is provided for any errors or issues that may arise.

## Feel free to contribute or modify the script to suit your needs!


### Summary of Sections:

1. **Features**: Describes what the script can do.
2. **Installation**: Detailed steps on how to install and configure it.
3. **Configuration**: Adjustments for settings like cleanup interval and radius.
4. **Commands**: How to manually trigger vehicle cleanup with a radius.
5. **Example Usage**: Shows how to use the script for both automatic and manual cleanup.
6. **Notifications**: The timing for cleanup notifications.
7. **How It Works**: Explains how the script functions.
8. **License**: Legal terms for usage.

This is the final structured script in Markdown format for your **Vehicle Cleanup Script**.
