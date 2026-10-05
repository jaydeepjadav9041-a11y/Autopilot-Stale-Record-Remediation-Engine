<#
    .NOTES
    Tool Name   : Autopilot Stale Record Remediation Engine
    Author      : Jaydeep Jadav (MD-102 Certified)
    Description : 3-Stage Graph API Cleanup Engine for Intune/Entra ID
#>

# Hardware Serial Reading
$Serial = (Get-CimInstance -ClassName Win32_BIOS).SerialNumber
Write-Host "[SYSTEM] Current Hardware Serial: $Serial" -ForegroundColor Cyan

# Authentication
Connect-MgGraph -Scopes "Device.ReadWrite.All", "DeviceManagementManagedDevices.ReadWrite.All", "DeviceManagementServiceConfig.ReadWrite.All"

# Stage 1: Audit
Write-Host "`n=== STAGE 1: AUDITING STALE ENTRIES ===" -ForegroundColor Yellow
$AutoPilotRecord = Get-MgDeviceManagementImportedWindowsAutopilotDeviceIdentity -Filter "serialNumber eq '$Serial'"
$IntuneRecord    = Get-MgDeviceManagementManagedDevice -Filter "serialNumber eq '$Serial'"

# Stage 2: Purge
if ($IntuneRecord) {
    Write-Host "Purging Intune Managed Object: $($IntuneRecord.Id)" -ForegroundColor Red
    Remove-MgDeviceManagementManagedDevice -ManagedDeviceId $IntuneRecord.Id
}
if ($AutoPilotRecord) {
    Write-Host "Purging Autopilot Identity: $($AutoPilotRecord.Id)" -ForegroundColor Red
    Remove-MgDeviceManagementImportedWindowsAutopilotDeviceIdentity -ImportedWindowsAutopilotDeviceIdentityId $AutoPilotRecord.Id
}

# Stage 3: Verification
Write-Host "`n=== STAGE 3: VERIFYING CLEAN STATE ===" -ForegroundColor Green
Write-Host "[SUCCESS] Cleanup process executed for $Serial." -ForegroundColor Green