## These are all constants that never change
# The name of the application (when launched)
# Get this from TaskManger or get-process
$epic_app='KINGDOM HEARTS HD 1.5+2.5 ReMIX'
# Full launcher URI com.epicgames.launcher://apps/68c214c58f694ae88c2dab6f209b43e4?action=launch&silent=true
# Get this by asking the EGL to make a desktop shortcut for your app
# opening the properties of the shortcut and looking at the string
$epic_app_launch_uri='com.epicgames.launcher://apps/68c214c58f694ae88c2dab6f209b43e4?action=launch&silent=true'

# Epic Launcher name
# This should be universal
# Chekc with git-process or with TaskManager
$epic_launcher='Epic Game Launcher'

Function _launch_game {
    # Launch the app
    Write-Output "Launching: $epic_app_launch_uri"
    Write-Output "  Waiting for $epic_app to complete"
    # Ask for the app to start
    Start-Process $epic_app_launch_uri

    # We need to wait AT LEAST a minute here as the EGL may not even be running yet
    # So we need to wait for the EGL to start AND then the app to start
    Start-Sleep -Seconds 60
    # Now pause and wait for the app to close
    Wait-Process $epic_app

    # After it exits report that it's closed
    Write-Output " $epic_app has exited - Closing the EpicLauncher"

    # Close the EpicLauncher since we no longer need it
    Stop-Process -Name $epic_launcher
}

_launch_game