/*
Dialog.create("Create custom masks for brain areas based on RGB values");
Dialog.addNumber("Red Value",0);
Dialog.addNumber("green Value",0);
Dialog.addNumber("Blue Value",0);
Dialog.addString("Title of new mask", "S1_L1_mask");
Dialog.show();

redValue = Dialog.getNumber();
greenValue = Dialog.getNumber();
blueValue = Dialog.getNumber();
maskTitle = Dialog.getString();
*/

macro "custom_mask" {
//annotationsFolder = getDirectory("Select annotations file directory"); 
arguments = split(getArgument(),",");
annotationsFolder = arguments[0];
annotationsFile = arguments[1];
redValue = arguments[2];
greenValue = arguments[3];
blueValue = arguments[4];
maskTitle = arguments[5];

open(annotationsFolder+annotationsFile);
selectWindow(annotationsFile);
run("Split Channels");

//Set red threshold
selectWindow("C1-"+annotationsFile);
setAutoThreshold("Default dark no-reset");
setThreshold(redValue, redValue);
setOption("BlackBackground", true);
run("Convert to Mask", "method=Default background=Dark black");

//Set green threshold
selectWindow("C2-"+annotationsFile);
setThreshold(greenValue, greenValue);
run("Convert to Mask", "method=Default background=Dark black");

//set blue threshold
selectWindow("C3-"+annotationsFile);
setThreshold(blueValue, blueValue);
run("Convert to Mask", "method=Default background=Dark black");

//create final mask
imageCalculator("Multiply create stack", "C1-"+annotationsFile,"C2-"+annotationsFile);
selectWindow("Result of C1-annotation_transformed_8bit.tif");
imageCalculator("Multiply create stack", "Result of C1-"+annotationsFile,"C3-"+annotationsFile);

//save final mask
selectWindow("Result of Result of C1-"+annotationsFile);
//Replace 255 with 1 (so that the image is either 0 (background) or 1 (region of interest), for easy multiplication)
run("Replace value", "pattern=255 replacement=1");

saveAs("Tiff", annotationsFolder+maskTitle+".tif");
close();
close();
close();
close();
close();
//run("Close"); //close threshold window
exit();
}