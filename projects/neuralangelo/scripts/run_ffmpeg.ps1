$Path_To_Video = $args[0]
$Skip_Frame_Rate = $args[1]

$Image_Path = "datasets\$($(Split-Path $Path_To_Video -Leaf).Split('.')[0])_skip$Skip_Frame_Rate\raw_images"
New-Item -ItemType Directory -Force -Path $Image_Path
ffmpeg -i $Path_To_Video -vf "select='not(mod(n,$Skip_Frame_Rate))'" -vsync vfr -q:v 2 "$Image_Path\%06d.jpg"
