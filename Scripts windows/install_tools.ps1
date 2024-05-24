# Verifica se o script está sendo executado como administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Este script deve ser executado com permissões de administrador."
    exit
}

# Função para instalar o winget caso não esteja instalado
function Install-Winget {
    $wingetInstaller = "https://aka.ms/MicrosoftAppsInstaller"
    $wingetInstallerPath = "$env:TEMP\MicrosoftAppsInstaller.appxbundle"
    Invoke-WebRequest -Uri $wingetInstaller -OutFile $wingetInstallerPath
    Add-AppxPackage -Path $wingetInstallerPath
    Remove-Item -Path $wingetInstallerPath
}

# Verifica se o winget está instalado
try {
    Get-Command winget -ErrorAction Stop
    Write-Output "winget já está instalado."
} catch {
    Write-Output "winget não está instalado. Instalando o winget..."
    Install-Winget

    # Aguarda alguns segundos para garantir que o winget esteja disponível
    Start-Sleep -Seconds 10
}

# Função para medir o tempo de execução de um comando
function Measure-ExecutionTime($scriptBlock) {
    $executionTime = [System.Diagnostics.Stopwatch]::StartNew()
    & $scriptBlock
    $executionTime.Stop()
    return $executionTime.Elapsed
}

# Instalar Python usando winget
$pythonTime = Measure-ExecutionTime { Start-Process -FilePath "winget" -ArgumentList "install -e --id Python.Python.3" -Wait }
Write-Output "Tempo de instalação do Python: $($pythonTime.TotalSeconds) segundos"

# Instalar Nmap usando winget
$nmapTime = Measure-ExecutionTime { Start-Process -FilePath "winget" -ArgumentList "install -e --id Insecure.Nmap" -Wait }
Write-Output "Tempo de instalação do Nmap: $($nmapTime.TotalSeconds) segundos"

# Instalar Visual Studio Code usando winget
$vscodeTime = Measure-ExecutionTime { Start-Process -FilePath "winget" -ArgumentList "install -e --id Microsoft.VisualStudioCode" -Wait }
Write-Output "Tempo de instalação do Visual Studio Code: $($vscodeTime.TotalSeconds) segundos"

# Instalar Docker Desktop
$dockerInstaller = "https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe"
$dockerInstallerPath = "$env:TEMP\DockerDesktopInstaller.exe"
Invoke-WebRequest -Uri $dockerInstaller -OutFile $dockerInstallerPath
$dockerTime = Measure-ExecutionTime { Start-Process -FilePath $dockerInstallerPath -ArgumentList "--quiet --install" -Wait }
Remove-Item -Path $dockerInstallerPath
Write-Output "Tempo de instalação do Docker Desktop: $($dockerTime.TotalSeconds) segundos"

# Instalar Google Drive
$googleDriveInstaller = "https://dl.google.com/drive-file-stream/GoogleDriveFileStream.exe"
$googleDriveInstallerPath = "$env:TEMP\GoogleDriveFileStream.exe"
Invoke-WebRequest -Uri $googleDriveInstaller -OutFile $googleDriveInstallerPath
$googleDriveTime = Measure-ExecutionTime { Start-Process -FilePath $googleDriveInstallerPath -ArgumentList "/S" -Wait }
Remove-Item -Path $googleDriveInstallerPath
Write-Output "Tempo de instalação do Google Drive: $($googleDriveTime.TotalSeconds) segundos"

Write-Output "Instalação concluída: Python, Nmap, Visual Studio Code, Docker Desktop, Google Drive e winget"

