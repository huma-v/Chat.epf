$ErrorActionPreference = "Stop"

# Read .env file into environment variables
if (Test-Path .env -PathType Leaf) {
    Get-Content .env | ForEach-Object {
        $name, $value = $_.split('=')
        Set-Item env:$name -Value $value
    }
}

# Create build output directory
New-Item .\build -ItemType Directory -Force

# Build the epf
$designer = Start-Process "${env:1C_HOME}\bin\1cv8.exe" "DESIGNER /LoadExternalDataProcessorOrReportFromFiles .\ChatEpf\ChatEpf.xml .\build\Chat.epf" -PassThru -Wait
if ($designer.ExitCode -ne 0) {
	throw "Error building epf!";
}
