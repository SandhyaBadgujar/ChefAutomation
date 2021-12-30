## This powershell script creates a self deleting scheduled task to change node's Chef environment
## This scheduled task can be used when chef environment needs to be changed at a point of time.

$run = (Get-Date).AddMinutes(60) # Task will run 60 minutes from now
Register-ScheduledTask -TaskName "Set Node Chef Environment" -User "Domain\Username" -Password "Password" -InputObject (
  (
    New-ScheduledTask -Action (
      New-ScheduledTaskAction -Execute "powershell.exe" -Argument ("C:/opscode/chef/bin/chef-client -L C:/chef/log/envtask.log -l info -c C:/chef/client.rb -s 300 -r recipe[set_env]")
    ) -Trigger (
      New-ScheduledTaskTrigger -Once -At ($run.TimeOfDay.ToString("hh\:mm")) # As a "TimeOfDay" to get 24Hr format
    ) -Settings (
      New-ScheduledTaskSettingsSet -WakeToRun -RestartOnIdle -RestartCount 3 -DeleteExpiredTaskAfter 00:00:01 # Delete one second after trigger expires
    ) -Principal ( New-ScheduledTaskPrincipal -RunLevel Highest -User "Domain\Username" -LogonType S4U) 
  ) | %{ $_.Triggers[0].EndBoundary = $run.AddMinutes(10).ToString('s') ; $_ } # Run through a pipe to set the end boundary of the trigger
) 
