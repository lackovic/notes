$packages = Get-ChildItem C:\ProgramData\chocolatey\lib\ -Recurse  *.nuspec | select fullname,name 
foreach($p in $packages){
        [XML]$xml=get-content $p.fullname
        $dependencies = $xml.package.metadata.dependencies.dependency
        foreach($d in $dependencies){
	        $obj = New-Object -TypeName psobject
	        $obj | Add-Member -MemberType NoteProperty -name package  -Value $xml.package.metadata.id
	        $obj | Add-Member -MemberType NoteProperty -name packageversion  -Value $xml.package.metadata.version
	        $obj | Add-Member -MemberType NoteProperty -name dependency  -Value  $d.id
	        $obj | Add-Member -MemberType NoteProperty -name dependencyversion  -Value  $d.version
	        $obj
        }
}