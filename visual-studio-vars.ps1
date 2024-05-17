# Path to the vcvars64.bat file
$vcvarsPath = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"

# Invoke the batch file and capture the environment variables it sets
& cmd /c "`"$vcvarsPath`" & set" | foreach {
    $name, $value = $_ -split '='
    Set-Item -Path "Env:\$name" -Value $value
}
