macro "extract_areas_with_mask" {
//This script is supposed to take 3 arguments, as follows. The split() is the only way I could find to actually pass several arguments via command line. 
arguments = split(getArgument(),",");

maskDir = arguments[0]; // Note that this needs to end with a "/"
redDir = arguments[1]; 
outputDir = arguments[2];
firstPlane = arguments[3];
lastPlane  = arguments[4]; 

setOption("ExpandableArrays", true);
setBatchMode("hide"); 

processFolder(maskDir,redDir,outputDir);
   
    function processFolder(maskDir,redDir,outputDir) {
    IJ.log("processing directory " + maskDir);
    maskList = getFileList(maskDir);
    redList = getFileList(redDir);
    
    for (i = firstPlane; i <= lastPlane; i++) {
		processFile(maskDir,maskList[i],redDir,redList[i],outputDir);             
        }
    }    


    function processFile(maskDir,maskListNo,redDir,redListNo,outputDir)     {
	IJ.log("   processing file " + maskListNo);

	//Open mask image
	open(maskDir + maskListNo);
	
	//Check if mask actually contains any ROI, otherwise, skip this image
	getStatistics(area,mean);
	if (mean > 0) 
	{
	
		run("Scale...", "x=- y=- width=2160 height=2560 interpolation=None average create title=scaled.tif");
		selectWindow("scaled.tif");
	
		//Opens red image 
		open(redDir + redListNo);
		imageCalculator("Multiply create", redListNo,"scaled.tif");
		selectWindow("Result of "+ redListNo);
		saveAs("Tiff", outputDir + File.separator+redListNo);
		close();
		close();
	}
	close();
    }
exit();
}   
