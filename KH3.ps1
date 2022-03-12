# How to install this launcher:
# 1. In Steam Click 'Add a Non-Steam Game...'
#    * Browse to 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
# 2. In your Steam Library find 'powershell' and open it's properties
#    * Update it's name to something you find usefule (probably this game's name)
#    * Set Launch Options to '~\git\epic_game_steam_launchers\GAME.ps1' (Replace GAME with this launcher's name)
#    * OPTIONAL: Replace the image (huge pain)

# How to create a new launcher:
# 1. Open the EGL and make a desktop shotcut of the game you want to use
# 2. Update the 'epic_app_launch_uri' string (see below)
# 3. Update the 'epic_app' string

# APP URI
# Get this by asking the EGL to make a desktop shortcut for your app
# opening the properties of the shortcut and looking at the 
# 'Web Document' tab, URL field (copy/paste the ENTIRE string)
$epic_app_launch_uri='com.epicgames.launcher://apps/0712176b5e3e49bfa8866c0ee1359f2d%3Ae345fdb9186645a48d30c3f85a8951dc%3Afd711544a06543e0ab1b0808de334120?action=launch&silent=true'

# APP Name as seen by windows
# The name of the application (when launched)
# Get this from TaskManger or get-process
# It's probably also the name you see on the EGL desktop shortcut
$epic_app='KINGDOM HEARTS III + Re Mind'

# Epic Launcher name
# This should be universal
# Check with git-process or with TaskManager
$epic_launcher='EpicGamesLauncher'

# How long to wait for the applciation (and EGL) to start
$wait_timeout=30

Function _launch_game {
    # Launch the app
    Write-Output "Launching: $epic_app_launch_uri"
    Write-Output "  Waiting for $epic_app to exit (at least $wait_timeout s)"
    # Ask for the app to start
    Start-Process $epic_app_launch_uri

    # We need to wait here as the EGL may not even be running yet
    # So we need to wait for the EGL to start AND then the app to start
    Start-Sleep -Seconds $wait_timeout
    # Now pause and wait for the app to close
    Wait-Process $epic_app

    # After it exits report that it's closed
    Write-Output " $epic_app has exited - Closing the EpicLauncher"

    # Close the EpicLauncher since we no longer need it
    Stop-Process -Name $epic_launcher
    # Leave that all on the screen for at least a second
    Start-Sleep -Seconds 1
}

_launch_game