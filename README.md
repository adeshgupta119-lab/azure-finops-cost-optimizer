# Azure FinOps Automation & Cost Governance Engine 💰☁️

[![FinOps](https://img.shields.io/badge/FinOps-Cost_Optimization-success?style=for-the-badge&logo=azuredevops&logoColor=white)](#)
[![PowerShell](https://img.shields.io/badge/PowerShell-Automation-5391FE?style=for-the-badge&logo=powershell&logoColor=white)](https://microsoft.com/powershell)
[![Azure Bicep](https://img.shields.io/badge/Azure_Bicep-IaC-0078D4?style=for-the-badge&logo=microsoft-azure&logoColor=white)](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)

An enterprise-ready **FinOps automation suite and cost intelligence engine**. Automatically discovers orphaned cloud resources, rightsizes underutilized compute, and schedules non-production environments to deliver **30% to 40% cloud cost reduction**.

---

## 📉 FinOps Automated Pillars

| Capability | Automated Function | Business & Cost Impact |
| :--- | :--- | :--- |
| **Orphaned Storage** | Scans for unattached managed disks across all subscriptions | Eliminates idle storage waste |
| **Compute Rightsizing** | 14-day CPU & RAM telemetry analysis (Avg CPU < 10%) | Recommends 1-2 SKU tier downgrades |
| **Off-Hours Scheduling** | Automated start at 08:00 & stop at 20:00 for Dev/UAT VMs | ~65% monthly compute savings on non-prod |
| **Anomaly Detection** | Alerts on run-rate spikes (>130% over 7-day average) | Catches runaway spend before billing cycle ends |

---

## 📂 Repository Layout

```
├── .github/
│   └── workflows/
│       └── finops-audit.yml              # Scheduled weekly automated FinOps audits
├── deploy/
│   └── bicep/
│       └── main.bicep                    # Managed Identity & reporting infrastructure
├── scripts/
│   └── powershell/
│       ├── Find-UnattachedDisks.ps1      # Scans & audits orphaned Azure disks
│       └── Start-Stop-NonProdVMs.ps1     # Automated Non-Prod VM scheduler
└── README.md
```

---

## 🚀 Usage

### 1. Run Unattached Disk Audit
```powershell
Connect-AzAccount
./scripts/powershell/Find-UnattachedDisks.ps1 -OutputCsv "./disks_waste_report.csv"
```

### 2. Run Non-Prod VM Auto-Scheduling
```powershell
# Stop all Dev/UAT tagged VMs
./scripts/powershell/Start-Stop-NonProdVMs.ps1 -Action Stop

# Start all Dev/UAT tagged VMs
./scripts/powershell/Start-Stop-NonProdVMs.ps1 -Action Start
```

---

## 👤 Author
**Adesh Gupta**  
*Lead DevSecOps Engineer & Enterprise Cloud Architect*  
- GitHub: [@adeshgupta119-lab](https://github.com/adeshgupta119-lab)  
- Email: [adeshgupta119@gmail.com](mailto:adeshgupta119@gmail.com)
