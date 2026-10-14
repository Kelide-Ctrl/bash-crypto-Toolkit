# Bash Crypto Toolkit

A menu-driven bash script for Kali Linux that demonstrates core cryptography operations using `openssl`.

## Features

1. Symmetric encryption/decryption (AES-256-CBC)
2. RSA key pair generation
3. Asymmetric encryption/decryption
4. File hashing (SHA-256)
5. Digital signing of a file
6. Signature verification

## Requirements

- Kali Linux (or any Linux distro with `openssl` installed)
- Bash

## Usage

Make the script executable, then run it:

```bash
chmod +x crypto_toolkit.sh
./crypto_toolkit.sh
```

Follow the on-screen menu to select an operation. Each option prompts for the file(s) and/or key(s) it needs.

## Example workflow
1 -> Encrypt a file symmetrically with a password
2 -> Decrypt it back with the same password
3 -> Generate an RSA key pair
4 -> Encrypt a short file with the public key
5 -> Decrypt it with the private key
6 -> Hash a file (SHA-256)
7 -> Sign a file with the private key
8 -> Verify the signature with the public key


## Author

Emmanuel Odewale
