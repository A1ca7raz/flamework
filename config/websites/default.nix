{
  default = true;

  listenAddresses = [ "0.0.0.0" "[::]" ];

  locations."/".return = "403";

  rejectSSL = true;
  #sslCertificate = "";
  #sslCertificateKey = "";
}
