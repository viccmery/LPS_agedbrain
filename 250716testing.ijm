// List of your image filenames (edit these to match your actual files)
filenames = newArray(
    "C03a_Exc_ACC_Z4_L23_tile2.tif",
    "C03a_Exc_HIP_Z4_SRA_tile4.tif",
    "C03b_Exc_ACC_Z4_L23_tile2.tif",
    "C03b_Exc_HIP_Z4_SLM_tile3.tif",
    "C03c_Exc_ACC_Z4_L23_tile2.tif",
    "C03c_Exc_HIP_Z4_SRA_tile4.tif"
);

// Input and output directories
inputDir = "C:/Users/victo/Desktop/MRes/25MresBarnes/250716puncta_segmentation/data/raw_images/";
outputDir = "C:/Users/victo/Desktop/MRes/25MresBarnes/250716puncta_segmentation/data/250717testing/";

// Process each file
for (i = 0; i < filenames.length; i++) {
    filename = filenames[i];
    
    // Open image
    open(inputDir + filename);
    
    // Resize
    run("Size...", "width=512 height=512 depth=45 constrain average interpolation=Bilinear");
    
    // Split channels
    run("Split Channels");
    
    // Get base name (remove .tif extension)
    baseName = replace(filename, ".tif", "");
    
    // Process C1 (Homer1)
    selectImage("C1-" + filename);
    run("Make Substack...", "slices=1-5");
    saveAs("Tiff", outputDir + "C1_" + baseName + ".tif");
    close();
    
    // Process C4 (Synaptophysin1)
    selectImage("C4-" + filename);
    run("Make Substack...", "slices=1-5");
    saveAs("Tiff", outputDir + "C4_" + baseName + ".tif");
    close();
    
    // Clean up
    close("*");
}

print("All images processed!");