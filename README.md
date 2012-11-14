Extract_peripheral_Int
======================

This ImageJ macro can process extracting mean intensity (and area) from Beads like objects.
What this macro doing as follwos:

 1. Binalization to make mask image
 2. Dilation for mask image
 3. Filling hole mask image
 4. Eroding several times to reduce the paricle size
 5. Detect Beads like objects by using Analyze particle. Detected objects are registerd to RoiManager
 6. Get mean and area value in small Roi for inner value
 7. Enlage registered Roi
 8. Get mean and area value in large Roi for outer value
 9. Subtract outer mean value from inner mean value to obtain peripheral mean intensity.

2012.11.14 Yoshiyuki Arai