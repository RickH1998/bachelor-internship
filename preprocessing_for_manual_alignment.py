# -*- coding: utf-8 -*-
"""
Pre-processing before the manual alignment procedure
"""

#load the parameters:
runfile('/home/wirrbel/ClearMap/docs/conf.py')
import ClearMap

execfile('/home/wirrbel/ClearMap/ClearMap/Scripts/2019-03-01 preprocessing/P14_66632/parameter_file.py')


#resampling operations:
#######################
#resampling for the correction of stage movements during the acquisition between channels:
resampleData(**CorrectionResamplingParameterCfos);
resampleData(**CorrectionResamplingParameterAutoFluo);

#Downsampling for alignment to the Atlas:
resampleData(**RegistrationResamplingParameter);

"""
After you're done, open the "autofluo_resampled.tif" file and the "template_25.tif" file in ImageJ. 
Go to Plugins -> Big Data Viewer -> Bigwarp. Open template_25 first, then autofluo_resampled. 
In both images, hit Shift + A to flip both to coronal view. 
Scroll around and match the files as closely as possible (left click + pull around to tilt your plane of view in 3d. Ctrl + Y to reset to starter view.)
Landmark procedure: 
    click on one of the windows to make sure you are active in the right window. 
    Press Space bar to activate the landmark mode. 
    Click on one of the landmarks. 
    click the other window, re-activate landmark mode by pressing space bar(twice, if need be)
    Mark the same landmark. 
    Repeat until approx. 50-100 landmarks are marked. 
Go to the landmarks window -> File -> Export landmarks. 
Open the resulting landmarks.csv file in LibreOffice/Excel. 
The first two columns can be ignored. Columns C-E are for the template_25 (and are measured in microns). Columns F-H are for the autofluo_resampled. 
Rescale the template_25 to pixels: In a different column, enter "=C1*0.04" (minus quotation marks). Extend until all the template_25 landmarks (NOT the autofluo landmarks, those are already in pixel coordinates!) are converted. 
Export the points to two different text files, atlas_landmarks.txt and autofluo_landmarks.txt. They should look as follows: 
    point                          <- Not "point" (quotation marks), not "points" (note the S), not "Point" (Capitalized). Clearmap will throw obscure errors if this is not correct! 
    [number of points]             <- not the number of coordinates, but the number of points 
    [Points X][Points Y][Points Z] <- Those should all be in 3 different columns, separated by a space. 
Copy both landmarks files to the folder of your sample. 
Mark the files in the parameter template (almost all the way down, ctrl+F "landmarks"). 
Save both parameter and process template
Klick run, set in the popup window the directory to current workdirectory

That's it! You should be good to go. 
"""
