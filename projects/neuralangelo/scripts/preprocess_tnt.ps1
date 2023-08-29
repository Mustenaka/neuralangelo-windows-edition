$Path_To_TNT = $args[0]

Write-Host "Download fixed poses for Courthouse"
# make sure u have ready install gdown(pip install gdown)
gdown 10pcCwaQY6hqyiegJGdgmLp_HMFOnsmgq
gdown 19TT5aTz3z60eUVIDhFJ7EgGqpcqQnJEi
Move-Item -Path Courthouse_COLMAP_SfM.log -Destination "$Path_To_TNT\Courthouse\Courthouse_COLMAP_SfM.log"
Move-Item -Path Courthouse_trans.log -Destination "$Path_To_TNT\Courthouse\Courthouse_trans.log"

Write-Host "Compute intrinsics, undistort images and generate json files. This may take a while"
python projects/neuralangelo/scripts/convert_tnt_to_json.py --tnt_path $Path_To_TNT
