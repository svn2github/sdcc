# Simple script that scans the given directory and sends an email for each
# blah

use Mail::Mailer;

$from = 'noreply@sourceforge.net';
$outgoing = 'mail.sourceforge.net';
$to = 'michaelh@juju.net.nz';
$dir = shift or die "Usage: perl runMailQueue.pl directory-to-scan\n";

opendir DIR, $dir or die "Unable to open $dir\n";

while ($name = readdir(DIR)) {
  if ($name =~ /^\./) {
    next;
  }
  $fullName = "$dir/$name";

  unless (-f $fullName) {
    next;
  }

  $mailer = new Mail::Mailer 'smtp', Server => $outgoing;

  $mailer->open({
                 To => $to,
                 From => $from,
                 Subject => 'Automated build output'
                });

  open IN, $fullName or die "Unable to open $fullName\n";

  while (<IN>) {
    print $mailer $_;
  }
  close IN;

  $mailer->close;

  unlink $fullName;
}
