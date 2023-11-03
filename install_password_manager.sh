#!/usr/bin/env bash

# install password store
git clone git@github.com:lferreira/pwd-store.git ~/.password-store
git clone git@github.com:lferreira/pwd-keys.git

#  Remember to edit the private key gpg --edit-key <private-key>
#  According to this post, OpenKeyChain doesn't suport AEAD encryption
#  (default in gpg 2.3). Dropping the OCB option from the key's preference
#  string also fixed the issue for me:
#
#  gpg --edit-key <key-id>
#	 gpg> showpref
#	 [ultimate] (1).name <email>
#	      Cipher: AES256, AES192, AES, 3DES
#	      AEAD: OCB
#	      Digest: SHA512, SHA384, SHA256, SHA224, SHA1
#	      Compression: ZLIB, BZIP2, ZIP, Uncompressed
#	      Features: MDC, AEAD, Keyserver no-modify
#	 gpg> setpref AES256 AES192 AES 3DES SHA512 SHA384 SHA256 SHA224 SHA1 ZLIB BZIP2 ZIP
#	 Set preference list to:
#	      Cipher: AES256, AES192, AES, 3DES
#	      AEAD:
#	      Digest: SHA512, SHA384, SHA256, SHA224, SHA1
#	      Compression: ZLIB, BZIP2, ZIP, Uncompressed
#	      Features: MDC, Keyserver no-modify
#	 Really update the preferences? (y/N) y
#	 gpg> save
#  pass init <key-id>

gpg --import ~/pwd-keys/private.pgp
gpg --import ~/pwd-keys/public.pgp
rm -rf ~/pwd-keys

# allow changes on the new machine - adds trust|5|save
gpg --edit-key luizhgferreira@gmail.com
