$credentials = ConvertFrom-Json "$(Get-Content "./credentials.json")"

pac auth create `
    --url $credentials.url `
    --applicationId $credentials.clientId `
    --clientSecret $credentials.clientSecret `
    --tenant $credentials.tenantId

Remove-Item con_Core.zip `
    -ErrorAction Ignore
pac solution export `
    --path con_Core.zip `
    --name con_Core `
    --async

Remove-Item con_Core_managed.zip `
    -ErrorAction Ignore
pac solution export `
    --path con_Core_managed.zip `
    --name con_Core `
    --managed `
    --async

pac solution unpack `
    --zipfile con_Core.zip `
    --folder solutions/con_Core/src `
    --packagetype Both `
    --allowDelete

pac auth clear
