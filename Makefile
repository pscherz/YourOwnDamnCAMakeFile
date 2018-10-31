#Mostly stolen from [https://stackoverflow.com/questions/21297139/how-do-you-sign-a-certificate-signing-request-with-your-certification-authority/21340898#21340898]

all: servercert.pem

# with own CA signed certificate 
servercert.pem: cakey.pem cacert.pem servercert.csr serverkey.pem index.txt serial.txt
	openssl ca -config openssl-ca.cnf -policy signing_policy -extensions signing_req -out servercert.pem -infiles servercert.csr

# own CA
cakey.pem: openssl-ca.cnf
	openssl req -x509 -config openssl-ca.cnf -newkey rsa:4096 -sha256 -nodes -out cacert.pem -outform PEM

# certificate signing request
servercert.csr: openssl-server.cnf
	openssl req -config openssl-server.cnf -newkey rsa:4096 -sha256 -nodes -out servercert.csr -outform PEM

index.txt:
	touch index.txt

serial.txt:
	echo '01' > serial.txt

.PHONY: all clean

# start anew
clean:
	rm -f rm index.txt serial.txt servercert.pem cakey.pem cacert.pem servercert.csr serverkey.pem index.txt serial.txt

