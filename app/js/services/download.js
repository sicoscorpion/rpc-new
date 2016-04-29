/*
 * File:        download.js
 * Author:      Martin Main
 * Date:        April 2016
 * Purpose:     This file provides some helper functions for processing files
 *              to download.
 * 
 */

/*
 * Name:    cleanup
 * Author:  Martin Main
 * Date:    April 2016
 * Purpose: This function quotes any array elements which contain 
 *          commas, and makes any null fields a blank string.
 * Arguments: array - contains the array being cleaned up
 */
function cleanup(array) {
    for (row in array) {
        for (element in array[row]) {
            if(typeof array[row][element] == 'string' && ~array[row][element].indexOf(',')) {
                array[row][element] = '"' + array[row][element] + '"';
            }
            if (array[row][element] === null) {
                array[row][element] = '';
            }
        }
    }
}


/*
 * Name:    downloadCSV
 * Author:  Martin Main
 * Date:    April 2016
 * Purpose: This function handles the downloading of csv files. When function
 *          is called, a window should pop up in the browser asking the user 
 *              if they want to download the file.
 * Arguments: filename - the name of the file being created.
 *            csv - a string containing CSV formatted data to be places in the
 *                  file being downloaded. 
 */
function downloadCSV(filename, csv) {
        var data, link;
        
        if (csv === null) return;

        filename1 = filename || 'export.csv';

        // 'saveAs' comes from fileSaver library, which supports 
        // cross-platform downloading of browser generated files. 
        var blob = new Blob([csv], {type: "text/csv;charset=utf-8"});
        saveAs(blob, filename1);

        // Old downloading method:
        // data = encodeURI(csv);

        // link = document.createElement('a');
        // link.setAttribute('href', data);
        // link.setAttribute('download', filename1);
        // link.setAttribute('target', '_blank');
        // document.body.appendChild(link);
        // link.click();
}