macro "merge_mask" {
//This function takes 5 arguments. 
arguments = split(getArgument(),",");
annotationsFolder = arguments[0];
annotationName1 = arguments[1];
annotationName2 = arguments[2];
annotationName3 = arguments[3];
finalFileName = arguments[4];

open(annotationsFolder+annotationName1+".tif");
open(annotationsFolder+annotationName2+".tif");
open(annotationsFolder+annotationName3+".tif");

run("Merge Channels...", "c1=" + annotationName1 + ".tif c2=" + annotationName2 + ".tif c3=" + annotationName3 + ".tif create");
saveAs("Tiff", annotationsFolder+finalFileName+".tif");
close();
exit();
} 