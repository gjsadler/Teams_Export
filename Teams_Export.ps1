
Connect-MircrosoftTeams 
Connect-ExchangeOnline
$AllTeamsInOrg =  Get-Team
$TeamList = @()

Foreach ($Team in $AllTeamsInOrg){
    
    $TeamGUID = $Team.GroupId
    $TeamName = (Get-Team | ?{$_.GroupID -eq $TeamGUID}).DisplayName
    $TeamChannels = (Get-TeamChannel -GroupId $TeamGUID).DisplayName
    $TeamType = (Get-Team -GroupId $TeamGUID).Visibility
    $TeamOwner = (Get-TeamUser -GroupId $TeamGUID | ?{$_.Role -eq 'Owner'}).User
    $OwnerList =@(Foreach ($owner in $TeamOwner){
		$member -replace "@witheemalcolm.com","@bsbdesign.com"
			})
    $TeamMember = (Get-TeamUser -GroupId $TeamGUID | ?{$_.Role -eq 'Member'}).User
	$MemberList =@(Foreach ($member in $TeamMember){
		$member -replace "@witheemalcolm.com","@bsbdesign.com"
			})
   
      $TeamList = $TeamList + [PSCustomObject]@{TeamName = $TeamName; TeamType = $TeamType; TeamChannel = $TeamChannels -join ', '; TeamOwners = $Ownerlist -join ';'; TeamMembers = $memberlist -join ';'}
    }
    $TeamList | export-csv c:\temp\TeamsData.csv -NoTypeInformation 


 