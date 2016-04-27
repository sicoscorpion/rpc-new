function downloadCSV(filename, csv) {
        var data, link;
        
        if (csv === null) return;

        filename1 = filename || 'export.csv';

        if (!csv.match(/^data:text\/csv/i)) {
            csv = 'data:text/csv;charset=utf-8,' + csv;
        }
        data = encodeURI(csv);

        link = document.createElement('a');
        link.setAttribute('href', data);
        link.setAttribute('download', filename1);
        link.setAttribute('target', '_blank');
        document.body.appendChild(link);
        link.click();
}