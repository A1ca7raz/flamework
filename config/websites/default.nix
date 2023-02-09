{
  default = true;

  listenAddresses = [ "0.0.0.0" "[::]" ];

  locations."/".return = "401";

  rejectSSL = true;
  #sslCertificate = "";
  #sslCertificateKey = "";
}
