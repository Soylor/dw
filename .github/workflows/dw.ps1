# URL del archivo XML en GitHub
$xmlUrl = "https://github.com/Soylor/dw/raw/main/.github/workflows/dw.xml"

# Ruta temporal para guardar el archivo XML
$xmlPath = "$env:TEMP\dw.xml"

# Descargar el archivo XML
Invoke-WebRequest -Uri $xmlUrl -OutFile $xmlPath
# Cargar el archivo XML
[xml]$xml = Get-Content $xmlPath

# Preguntar por el cliente
$clienteNombre = Read-Host "Introduce el nombre del cliente"

# Obtener el nombre del equipo actual
$computerName = $env:COMPUTERNAME

# Buscar el código del equipo en el archivo XML
$codigo = $null
foreach ($cliente in $xml.Clientes.Cliente) {
    if ($cliente.nombre -eq $clienteNombre) {
        foreach ($pc in $cliente.PC) {
            if ($pc.nombre -eq $computerName) {
                $codigo = $pc.codigo
                break
            }
        }
    }
    if ($codigo) { break }
}

if ($codigo) {
    # URL de descarga del agente DWService
    $dwServiceUrl = "https://www.dwservice.net/download/dwagent_x86.exe"

    # Ruta temporal para guardar el agente
    $tempPath = "$env:TEMP\dwagent_x86.exe"

    # Descargar el agente
    Invoke-WebRequest -Uri $dwServiceUrl -OutFile $tempPath

    # Ejecutar la instalación desatendida
    Start-Process -FilePath $tempPath -ArgumentList "/S /CODE=$codigo" -Wait

    Write-Output "Instalación completada para el equipo $computerName con el código $codigo."
} else {
    Write-Output "No se encontró el código para el equipo $computerName en el cliente $clienteNombre en el archivo XML."
}
