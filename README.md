\# 🛡️ Enterprise Autopilot Stale Record Remediation Engine



An enterprise-grade, dual-authenticated PowerShell automation engine leveraging \*\*Microsoft Graph API\*\* to audit, purge, and verify stale Entra ID, Intune Managed Device, and Autopilot Hash records prior to device re-provisioning.



\---



\## 📌 Business Problem \& Impact

When re-imaging enterprise laptops, stale/duplicate device records create enrollment collisions in Microsoft Entra ID \& Intune.

\- \*\*Previous Approach:\*\* Manual portal cleanup (Requires full admin access, \~20 mins per ticket).

\- \*\*Engine Approach:\*\* 3-Stage Automated Remediation via Graph API (\~30 seconds execution with audit logging).



\---



\## 🏗️ Architecture \& Execution Flow

1\. \*\*Stage 1 \[Audit]:\*\* Queries Entra ID, Intune, and Autopilot DB using local motherboard serial (`Win32\_BIOS`).

2\. \*\*Stage 2 \[Purge]:\*\* Safely deletes target stale records upon confirmation.

3\. \*\*Stage 3 \[Verification]:\*\* Re-queries Graph API to confirm 100% clean state.



\---



\## 🔒 Security Guardrails

\- \*\*Transport Security:\*\* Purely HTTPS Port 443 (TLS 1.3) to `graph.microsoft.com`.

\- \*\*Dual Authentication:\*\* Enterprise Certificate Store (On-Site) \& Delegated OAuth 2.0 MFA (Field).

\- \*\*Auditability:\*\* Every action is logged in Entra ID Audit Logs.



\---



\## 👤 Author

\*\*Jaydeep Jadav\*\*  

\*Endpoint Administrator (MD-102 Certified)\*

