################################################################################
#.SYNOPSIS
#   Decline-WindowsX86.ps1
#   A helper script function to identify Windows 32-bit updates
#      for declining in WSUS and expiring in ConfigMgr/SCCM
#.LINK
#   Reference Invoke-DGASoftwareUpdateMaintenance.ps1
#.NOTES
#   This script is invoked by Invoke-DGASoftwareUpdateMaintenance.ps1 and not run independently
#
#   This script is maintained at https://github.com/ChadSimmons/Scripts
#   Additional information about the function or script.
#   ========== Keywords ==========
#   Keywords: WSUS SUP SCCM ConfigMgr Decline Expire Update Maintenance Superseded
#   ========== Change Log History ==========
#   - 2018/04/30 by Chad.Simmons@CatapultSystems.com - Created
#   - 2018/04/30 by Chad@ChadsTech.net - Created
#   === To Do / Proposed Changes ===
#   - TODO: None
################################################################################


Function Invoke-SelectUpdatesPlugin{
    $DeclineUpdates = @{}
    $WindowsX86Updates = ($ActiveUpdates | Where{($_.Title -notlike '*.NET*') -and ($_.Title -ilike '*x86*') -and ($_.ProductTitles -ilike '*Windows*') -and (!$_.ProductTitles.Contains('Windows Server 2008'))})
    #WINDOWS7CLIENT-KB982799-X86-308159-23798
    #WINDOWS7EMBEDDED-KB2124261-X86-325274-25932
    #KB4099989-Windows10Rs3Client-RTM-ServicingStackUpdate-X86-TSL-World
    #KB947821-Win7-SP1-X86-TSL
    #WINDOWS6-1-KB975891-X86-294176

    #Loop through the updates and decline any that match the version.
    ForEach ($Update in $WindowsX86Updates) {
        $DeclineUpdates.Set_Item($Update.Id.UpdateId,"Windows X86 (32-bit)")
    }
    Return $DeclineUpdates
}
