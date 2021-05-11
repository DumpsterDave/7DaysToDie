[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)]
    [string]$XmlPath = 'G:\Steam Games\steamapps\common\7 Days To Die\Data\Config\item_modifiers.xml'
)

if (-not (Test-Path $XmlPath -PathType Leaf)) {
    Write-Error "Failed to load $($XmlPath): Could not locate or access the file."
} else {
    [xml]$Xml = Get-Content -Path $XmlPath
    $Mods = $Xml.item_modifiers.item_modifier

    <# Collects the list of passive effects.  Might do something with this later.
    $EffectTypes = [System.Collections.Generic.List[Object]]::new()
    foreach ($effect in $Mods.effect_group.passive_effect) {
        if (-not $EffectTypes.Contains($effect.name)) {
            [void]$EffectTypes.Add($effect.name)
        }

    }
    $PassiveEffects = $EffectTypes.ToArray()
    #>

    #Collect the list of tags
    $InstallableTags = [System.Collections.Generic.List[Object]]::new()
    $BlockedTags = [System.Collections.Generic.List[Object]]::new()
    foreach ($mod in $Mods) {
        if ($mod.installable_tags -match ',') {
            try{
                $InstTags = $mod.installable_tags -split ','
                foreach ($tag in $InstTags) {
                    if (-not $InstallableTags.Contains($tag)) {
                        [void]$InstallableTags.add($tag)
                    }
                }
            } catch {
                Write-Error "$($_.ExceptionMessage)"
            }
            
        } else {
            if (-not $InstallableTags.Contains($mod.installable_tags)) {
                [void]$InstallableTags.Add($mod.installable_tags)
            }
        }
        if ($mod.blocked_tags -match ',') {
            try {
                $BlockTags = $mod.blocked_tags -split ','
                Write-Host $BlockTags -ForegroundColor blue
                foreach ($tag in $BlockTags) {
                    if (-not $BlockedTags.Contains($tag)) {
                        [void]$BlockedTags.Add($tag)
                    }
                }
            } catch {
                Write-Error "$($_.ExceptionMessage)"
            }
            
        } else {
            if (-not $BlockedTags.Contains($mod.blocked_tags)) {
                [void]$BlockedTags.Add($mod.blocked_tags)
            }
        }
        
    }

    foreach ($mod in $Mods) {
        #$InstallableTags ??= $mod.installable_tags.split(',')
        #$ModifierTags ??= $mod.modifier_tags.split(',')
        #$BlockedTags ??= $mod.blocked_tags.split(',')
        $Type = $mod.type
     
    }
    #$EffectTypes

}