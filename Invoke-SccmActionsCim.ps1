# This is a script block which can be used to trigger SCCM update schedules against a remote client. More guidKey strings are available on Microsoft's Documentation.

function Invoke-SccmActionsCim{
    $guidTable = @{
        '{00000000-0000-0000-0000-000000000001}' = 'Hardware Inventory'
        '{00000000-0000-0000-0000-000000000002}' = 'Software Inventory'
        '{00000000-0000-0000-0000-000000000003}' = 'Data Discovery Record'
        '{00000000-0000-0000-0000-000000000010}' = 'File Collection'
        '{00000000-0000-0000-0000-000000000021}' = 'Machine Policy Assignments Request'
        '{00000000-0000-0000-0000-000000000022}' = 'Machine Policy Evaluation'
        '{00000000-0000-0000-0000-000000000023}' = 'Refresh Default MP Task'
        '{00000000-0000-0000-0000-000000000024}' = 'LS (Location Service) Refresh Locations Task'
        '{00000000-0000-0000-0000-000000000025}' = 'LS (Location Service) Timeout Refresh Task'
        '{00000000-0000-0000-0000-000000000031}' = 'Software Metering Generating Usage Report'
        '{00000000-0000-0000-0000-000000000032}' = 'Source Update Message'
        '{00000000-0000-0000-0000-000000000040}' = 'Machine Policy Agent Cleanup'
        '{00000000-0000-0000-0000-000000000042}' = 'Policy Agent Validate Machine Policy / Assignment'
        '{00000000-0000-0000-0000-000000000051}' = 'Retrying/Refreshing certificates in AD on MP'
        '{00000000-0000-0000-0000-000000000108}' = 'Software Updates Assignments Evaluation Cycle'
        '{00000000-0000-0000-0000-000000000111}' = 'Send Unsent State Message'
        '{00000000-0000-0000-0000-000000000112}' = 'State System policy cache cleanout'
        '{00000000-0000-0000-0000-000000000113}' = 'Scan by Update Source'
        '{00000000-0000-0000-0000-000000000114}' = 'Update Store Policy'
        '{00000000-0000-0000-0000-000000000116}' = 'State system policy bulk send low'
        '{00000000-0000-0000-0000-000000000131}' = 'Power management start summarizer'
        '{00000000-0000-0000-0000-000000000221}' = 'Endpoint deployment reevaluate'
        '{00000000-0000-0000-0000-000000000222}' = 'Endpoint AM policy reevaluate'
        '{00000000-0000-0000-0000-000000000223}' = 'External event detection'
    }
    
    foreach($g in $guidTable.Keys){
        Invoke-CimMethod -Namespace 'root\CCM' -ClassName SMS_Client -MethodName TriggerSchedule -Arguments @{
            sScheduleID = $g
        } | Out-Null
        Write-Host "Invoked schedule" $guidTable[$g] -ForegroundColor Green
    }
}
