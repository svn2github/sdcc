# Simple script that sends an email.

use Mail::Mailer;

$from = 'noreply@sourceforge.net';
$outgoing = 'mail.sourceforge.net';

$to = shift or die "Usage: perl sendMessage.pl to\@somewhere.com\n";

$mailer = new Mail::Mailer 'smtp', Server => $outgoing;

$mailer->open({
               To => $to,
               From => $from,
               Subject => 'Automated build output'
              });

while (<>) {
  print $mailer $_;
}

$mailer->close;
