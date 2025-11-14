// BulkRenameUtility script to reduce the hour of a date by one hour of filenames in the format "YYYY-MM-DD HH.MM.SS"
// Example: 2021-01-01 23.59.59 -> 2021-01-01 22.59.59
// Assumes that the hour is never 00

function reduceOneHour(dateString) {
    const parts = dateString.split("\\");
    const lastPart = parts.pop();
    const hour = Number(lastPart.substring(11, 13));
    var newHour = (hour - 1);
    newHour = newHour < 10 ? "0" + newHour : "" + newHour;
    const newLastPart = lastPart.substring(0, 11) + newHour + lastPart.substring(13);
    return parts.length ? parts.join("\\") + "\\" + newLastPart : newLastPart;
}

newName = reduceOneHour(name);
