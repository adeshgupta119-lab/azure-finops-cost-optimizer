[CmdletBinding()]
param(
    [string]$OutputCsv = "./unattached_disks_report.csv"
)

Write-Host "[+] Connecting to Azure subscriptions..." -ForegroundColor Cyan
$subscriptions = Get-AzSubscription -ErrorAction SilentlyContinue

if (-not $subscriptions) {
    Write-Warning "Run 'Connect-AzAccount' to authenticate."
    exit 1
}

$unattachedDisks = @()

foreach ($sub in $subscriptions) {
    Set-AzContext -SubscriptionId $sub.Id | Out-Null
    Write-Host "[+] Scanning Subscription: $($sub.Name)..." -ForegroundColor Gray

    $disks = Get-AzDisk | Where-Object { [string]::IsNullOrEmpty($_.ManagedBy) }

    foreach ($disk in $disks) {
        $unattachedDisks += [PSCustomObject]@{
            SubscriptionName  = $sub.Name
            SubscriptionId    = $sub.Id
            ResourceGroupName = $disk.ResourceGroupName
            DiskName          = $disk.Name
            DiskSizeGB        = $disk.DiskSizeGB
            SkuTier           = $disk.Sku.Name
        }
    }
}

if ($unattachedDisks.Count -gt 0) {
    Write-Host "[!] Found $($unattachedDisks.Count) unattached managed disks!" -ForegroundColor Yellow
    $unattachedDisks | Export-Csv -Path $OutputCsv -NoTypeInformation
} else {
    Write-Host "[✓] Zero unattached disks detected." -ForegroundColor Green
}

