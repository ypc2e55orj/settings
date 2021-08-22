function Get-SubnetMask([UInt16]$Prefix) {
    [UInt16[]]$SubnetMask = 0, 0, 0, 0
    for (($bit = 0), ($index = 0); $bit -lt 32; ($bit++), ($index = $bit -shr 3)) {
        $SubnetMask[$index] = $SubnetMask[$index] -shl 1
        if ($Prefix -gt 0) {
            $Prefix--
            $SubnetMask[$index]++
        }
    }
    return $SubnetMask
}

function Get-NetworkAddress([UInt16[]]$Address, [UInt16[]]$SubnetMask) {
    [UInt16[]]$NetworkAddress = 0, 0, 0, 0
    for ($index = 0; $index -lt 4; $index++) {
        $NetworkAddress[$index] = $Address[$index] -band $SubnetMask[$index]
    }
    return $NetworkAddress
}

function Get-NetWSLIPAddress() {
    return Get-NetIPAddress `
    | Where-Object {
        ($_.InterfaceAlias -eq "vEthernet (WSL)") -and ($_.AddressFamily -eq "IPv4")
    }
}

function Set-NetFirewallWSLAllow([string]$DisplayName) {
    # WSL IPv4 address
    $WSLIPv4Object = Get-NetWSLIPAddress
    $WSLIPv4Address = [UInt16[]]($WSLIPv4Object.IPv4Address -split "\.")
    $WSLSubnetMask = Get-SubnetMask -Prefix $WSLIPv4Object.PrefixLength
    $WSLNetworkAddress = Get-NetworkAddress `
        -Address $WSLIPv4Address `
        -SubnetMask $WSLSubnetMask
    $WSLNetworkAddressCIDRString = ($WSLNetworkAddress -join ".") `
        + "/" + $WSLIPv4Object.PrefixLength
    # Search rules
    $SameDisplayNameFirewallRules = Get-NetFirewallRule `
    | Where-Object {
        ($_.DisplayName -eq $DisplayName) `
            -and ($_.Direction -eq "Inbound") `
            -and ($_.Profile -eq "Public") `
            -and ($_.Action -eq "Allow")
    }
    # if firewall rules are not found, exit
    if ($null -eq $SameDisplayNameFirewallRules) {
        throw ("Firewall rule """ + $DisplayName + """ is not found!")
    }
    # Apply WSL IPv4 address to same display name rules
    foreach ($SameDisplayNameFirewallRule in $SameDisplayNameFirewallRules) {
        Write-Output ("Applying WSL Network Address(" + $WSLNetworkAddressCIDRString + ") to " + """" + $SameDisplayNameFirewallRule.Name + """")
        Set-NetFirewallRule `
            -Name $SameDisplayNameFirewallRule.Name `
            -EdgeTraversalPolicy Block `
            -RemoteAddress $WSLNetworkAddressCIDRString `
            -LocalAddress $WSLNetworkAddressCIDRString
    }
}

while($true) {
    if (Get-NetWSLIPAddress) {
        Set-NetFirewallWSLAllow -DisplayName "x410"
        Set-NetFirewallWSLAllow -DisplayName "VcXsrv windows xserver"
        Set-NetFirewallWSLAllow -DisplayName "pulseaudio.exe"
        break
    }
    Start-Sleep -Seconds 1
}
