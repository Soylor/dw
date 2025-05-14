# Ruta del ejecutable de desinstalación del agente DWService
$uninstallPath = "C:\Program Files\DWAgent\uninstall.exe"

if (Test-Path $uninstallPath) {
    # Ejecutar la desinstalación
    Start-Process -FilePath $uninstallPath -ArgumentList "/S" -Wait

    Write-Output "Desinstalación completada para el agente DWService."
} else {
    Write-Output "No se encontró el agente DWService instalado en este equipo."
}
