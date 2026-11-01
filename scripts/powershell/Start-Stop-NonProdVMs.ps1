[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("Start", "Stop")]
    [string]$Action
)

Write-Host "[+] Running FinOps VM Automation - Action: $Action" -ForegroundColor Cyan

$vms = Get-AzVM -Status | Where-Object {
    ($_.Tags["AutoSchedule"] -eq "true") -or
    ($_.Tags["Environment"] -match "(Dev|UAT|Sandbox)")
}

foreach ($vm in $vms) {
    $powerState = ($vm.Statuses | Where-Object Code -like "PowerState*").DisplayStatus

    if ($Action -eq "Stop" -and $powerState -eq "VM running") {
        Write-Host "[-] Deallocating VM: $($vm.Name)..." -ForegroundColor Yellow
        Stop-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name -Force -NoWait
    }
    elseif ($Action -eq "Start" -and $powerState -ne "VM running") {
        Write-Host "[+] Starting VM: $($vm.Name)..." -ForegroundColor Green
        Start-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name -NoWait
    }
}

Write-Host "[✓] VM $Action automation completed." -ForegroundColor Green

