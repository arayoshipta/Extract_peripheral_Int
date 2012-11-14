// Extract peripheral mean intensity
// Written by Yoshiyuki Arai
// ISIR, Osaka University
// 2012.11.14

macro "Extract_peripheral_Int" {
	title = getTitle();

//	print(title);
	
	run("Duplicate...", "title=binary"); // Make duplicate for binary image
	setAutoThreshold("Default dark"); // auto threshold
	run("Convert to Mask"); // make binary
	run("Dilate"); // Dilation 
	run("Fill Holes"); // Fill holes
	numOferode = getNumber("How many times do you want to erode?",4); // Ask how many times of erode is require.
	for(i=0;i<numOferode;i++){
		run("Erode"); 
	} // For loop for multiple erode to make small Roi
	run("Open"); // Open to remove thin lines and small particles

	// Perform Analyze partilces
	run("Analyze Particles...", "size=100-Infinity circularity=0.90-1.00 show=Nothing exclude clear add");

	count = roiManager("count"); // Get number of registered Roi
	el = getNumber("How enlarge?",3); // Ask how enlarge the Roi
	selectWindow(title); // Switch window to Original image
	yn = getBoolean("Do you want to add enlarged outer Roi to manager?"); // Ask whether registe enlarged, puter Roi or not
	for (i=0; i<count;i++) {
		roiManager("Select", i); // Selece ith Roi
		getStatistics(area,mean); // Get area and mean values of inner Roi
		run("Enlarge...", "enlarge="+el); // Do Enlarge
		getStatistics(area2,mean2); // Get area and mean values Outer Roi
		setResult("Inner Area",i,area); 
		setResult("Inner Mean",i,mean); 
		setResult("Outer Area",i,area2);
		setResult("Outer Mean",i,mean2); 
		setResult("Peripheral Area",i,area2-area);
		setResult("Peripheral Mean",i,mean2-mean);// Put area and mean values on Result table
		if(yn) roiManager("add"); // Add Roi manger to outer Roi
	}
	roiManager("Show All with labels");
	roiManager("Show All");
}