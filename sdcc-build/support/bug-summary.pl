# Simple script that downloads the open bug list for a given group and turns it into
# a bit of text.

$groupid = shift;

if (not $groupid) {
  # Default to sdcc
  $groupid = '599';
}

$url = "http://sourceforge.net/tracker/\\?atid=100599\\&group_id=$groupid\\&func=browse";

# Use wget to pull the current list
open LIST, "wget -O - -q $url |" or die "Fish!";

while (<LIST>) {
  if (/\/tracker\/index.php\?func=detail/) {
    # Pull out all </TD>'s
    s/\<\/TD\>//ig;
    # Strip out all anchors
    s/\<\/*a.*?\>//ig;
    # Split into parts based on the <TD>'s
    ($noise, $id, $description, $date, $assignedto, $drop) = split /\<TD.*?\>/;

    printf "%7s %-16s $description\n", $id, $assignedto;
  }
  else {
    # Noise, drop.
  }
}

close LIST;
