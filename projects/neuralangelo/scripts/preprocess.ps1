$Experiment_Name = $args[0]
$Path_To_Video = $args[1]
$Skip_Frame_Rate = $args[2]
$Scene_Type = $args[3]

Write-Output $Path_To_Video
$Image_Path = "datasets\$($(Split-Path $Path_To_Video -Leaf).Split('.')[0])_skip$Skip_Frame_Rate"
Write-Output $Image_Path

./projects/neuralangelo/scripts/run_ffmpeg.ps1 $Path_To_Video $Skip_Frame_Rate
./projects/neuralangelo/scripts/run_colmap.ps1 $Image_Path
python projects/neuralangelo/scripts/convert_data_to_json.py --data_dir "$Image_Path\dense" --scene_type $Scene_Type
python projects/neuralangelo/scripts/generate_config.py --experiment_name $Experiment_Name --data_dir "$Image_Path\dense" --scene_type $Scene_Type --auto_exposure_wb
