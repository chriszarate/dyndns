<?php

  require_once('NFSN/API/Manager.php');

  $api_key    = 'api_key';     // obtain from NFSN
  $user_name  = 'user_name';   // your NFSN username

  $passphrase = 'passphrase';  // sent via query string parameter

  $domain = 'example.com';     // domain under NFSN DNS
  $record = 'subdomain';       // the `A` record you want to update

  if (!(isset($_GET['knock']) && $_GET['knock'] == $passphrase)):
    exit;
  endif;

  $api = new APIManager($user_name, $api_key, false);
  $dns = $api->NewDNS($domain);

  $current = split(',', $dns->ListRRs($record));

  $old = split(':', $current[2]);
  $old = str_replace('"', '', $old[1]);
  $new = $_SERVER['REMOTE_ADDR'];

  if ($new):
    if ($old && $new !== $old):
      $dns->RemoveRR($record, 'A', $old);
    endif;
    if ($new !== $old):
      $dns->AddRR($record, 'A', $new);
      print 'Success: ' . $new;
    else:
      print 'No update.';
    endif;
  endif;

?>
