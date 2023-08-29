$Project_Path = $args[0]

New-Item -ItemType Directory -Force -Path "$Project_Path\sparse"
New-Item -ItemType Directory -Force -Path "$Project_Path\dense"

colmap feature_extractor `
    --database_path "$Project_Path\database.db" `
    --image_path "$Project_Path\raw_images" `
    --ImageReader.camera_model=RADIAL `
    --SiftExtraction.use_gpu=$true `
    --SiftExtraction.num_threads=32 `
    --ImageReader.single_camera=$true # assuming single camera

colmap sequential_matcher `
    --database_path "$Project_Path\database.db" `
    --SiftMatching.use_gpu=$true

colmap mapper `
    --database_path "$Project_Path\database.db" `
    --image_path "$Project_Path\raw_images" `
    --output_path "$Project_Path\sparse"

colmap image_undistorter `
    --image_path "$Project_Path\raw_images" `
    --input_path "$Project_Path\sparse\0" `
    --output_path "$Project_Path\dense" `
    --output_type COLMAP `
    --max_image_size 2000

Remove-Item -Recurse -Force "$Project_Path\sparse"
