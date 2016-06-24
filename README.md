# Skin-Color-Model
A simple Matlab implementation of paper: S.L. Phung, A. Bouzerdoum
, D. Chai, "A novel skin color model in YCbCr color space and its application to human face detection", ICIP 2002.

# Required:
1. Plot Gaussian ellipsoid: http://www.mathworks.com/matlabcentral/fileexchange/16543-plot-gaussian-ellipsoid
<br>
2. Dataset: <br>
lfw images: http://vis-www.cs.umass.edu/lfw/lfw-funneled.tgz <br>
labeled parts: http://vis-www.cs.umass.edu/lfw/part_labels/parts_lfw_funneled_gt_images.tgz

# Execution
Put the plot_gaussian_ellipsoid.m and the decompressed images to the same folder as the downloaded files.
## Training: modify the file path if necessary, this example only takes one image for training
Run skin_train.m

