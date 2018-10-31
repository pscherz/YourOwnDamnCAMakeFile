#What
Creates a Certificate Authority and signed certificate with one simple make call.

#Here be dragons
Should you be so brave as to use this for yourself, you might want to change the stuff in the *_distinguished_name sections in the .cnf files to reflect information of your own.
Also in openssl-server.cnf you should additionally change the alternate_names section.

#HOW
Just use gnu make with the default target. It creates
* cacert.pem: public key of the CA
* cakey.key: private key of the CA
* servercert.pem: signed certificate of the server(s)
* serverkey.pem: private key of the server(s)
* and some other stuff you actually know more about than me

##Green lock in Firefox
In your webserver (apache2 for me) you could for instance put them in /etc/ssl-global.conf like so:

    SSLCertificateFile /etc/apache2/ssl.crt/servercert.crt
    SSLCertificateKeyFile /etc/apache2/ssl.key/serverkey.key
    SSLCertificateChainFile /etc/apache2/ssl.crt/cacert.crt

In Firefox you import your cacert.crt into the CA Tab of the certificate management and don't forget to at least check the option to allow identification of websites.

Now, if I didn't skip something important, there should be a green lock on your next visit to your website.

##curl
Use the option '--cacert' to allow curl to use your website like this:
    curl --cacert cacert.pem https://myserver.local/index.html

#Thanks
Couldn't have made this without [this excellent answer on stackoverflow](https://stackoverflow.com/questions/21297139/how-do-you-sign-a-certificate-signing-request-with-your-certification-authority/21340898#21340898). 
