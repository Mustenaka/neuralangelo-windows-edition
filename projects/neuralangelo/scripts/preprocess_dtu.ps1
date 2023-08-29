$Path_To_DTU = $args[0]

Write-Host "Download DTU data"
New-Item -ItemType Directory -Force -Path "$Path_To_DTU"
Invoke-WebRequest -Uri "https://www.dropbox.com/sh/w0y8bbdmxzik3uk/AAAaZffBiJevxQzRskoOYcyja?dl=1" -OutFile data.zip
Expand-Archive -Path data.zip -DestinationPath $Path_To_DTU
Remove-Item -Path data.zip
Expand-Archive -Path "$Path_To_DTU\data_DTU.zip" -DestinationPath $Path_To_DTU -Force
Remove-Item -Path "$Path_To_DTU\data_DTU.zip"

Write-Host "Generate json files"
python projects/neuralangelo/scripts/convert_dtu_to_json.py --dtu_path $Path_To_DTU
