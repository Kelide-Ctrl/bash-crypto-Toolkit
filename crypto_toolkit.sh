#!/bin/bash
# crypto_toolkit.sh - Symmetric & Asymmetric Encryption, Hashing, and Digital Signature Toolkit

set -e   # exit immediately if a command fails, so errors don't cascade silently

show_menu() {
    echo "============================================="
    echo "      BASH CRYPTOGRAPHY TOOLKIT"
    echo "============================================="
    echo "1. Symmetric Encryption"
    echo "2. Symmetric Decryption"
    echo "3. Generate RSA Key Pair"
    echo "4. Asymmetric Encryption"
    echo "5. Asymmetric Decryption"
    echo "6. Hash a File"
    echo "7. Digitally Sign a File"
    echo "8. Verify a Signed File"
    echo "9. Exit"
    echo "============================================="
}

symmetric_encrypt() {
    read -p "Enter file to encrypt: " infile
    read -sp "Enter password: " password
    echo
    outfile="${infile}.enc"
    openssl enc -aes-256-cbc -salt -pbkdf2 -in "$infile" -out "$outfile" -pass pass:"$password"
    echo "Encrypted -> $outfile"
}

symmetric_decrypt() {
    read -p "Enter file to decrypt: " infile
    read -sp "Enter password: " password
    echo
    outfile="${infile%.enc}.dec"
    openssl enc -aes-256-cbc -d -pbkdf2 -in "$infile" -out "$outfile" -pass pass:"$password"
    echo "Decrypted -> $outfile"
}

generate_keys() {
    read -p "Enter a name for the key pair (e.g. mykey): " keyname
    openssl genrsa -out "${keyname}_private.pem" 2048
    openssl rsa -in "${keyname}_private.pem" -pubout -out "${keyname}_public.pem"
    echo "Generated ${keyname}_private.pem and ${keyname}_public.pem"
}

asymmetric_encrypt() {
    read -p "Enter file to encrypt: " infile
    read -p "Enter public key file: " pubkey
    outfile="${infile}.rsa"
    openssl pkeyutl -encrypt -pubin -inkey "$pubkey" -in "$infile" -out "$outfile"
    echo "Encrypted -> $outfile"
}

asymmetric_decrypt() {
    read -p "Enter file to decrypt: " infile
    read -p "Enter private key file: " privkey
    outfile="${infile%.rsa}.decrypted"
    openssl pkeyutl -decrypt -inkey "$privkey" -in "$infile" -out "$outfile"
    echo "Decrypted -> $outfile"
}

hash_file() {
    read -p "Enter file to hash: " infile
    openssl dgst -sha256 "$infile"
}

sign_file() {
    read -p "Enter file to sign: " infile
    read -p "Enter private key file: " privkey
    outfile="${infile}.sig"
    openssl dgst -sha256 -sign "$privkey" -out "$outfile" "$infile"
    echo "Signature created -> $outfile"
}

verify_file() {
    read -p "Enter original file: " infile
    read -p "Enter signature file: " sigfile
    read -p "Enter public key file: " pubkey
    openssl dgst -sha256 -verify "$pubkey" -signature "$sigfile" "$infile"
}

while true; do
    show_menu
    read -p "Choose an option [1-9]: " choice
    case $choice in
        1) symmetric_encrypt ;;
        2) symmetric_decrypt ;;
        3) generate_keys ;;
        4) asymmetric_encrypt ;;
        5) asymmetric_decrypt ;;
        6) hash_file ;;
        7) sign_file ;;
        8) verify_file ;;
        9) echo "Goodbye."; exit 0 ;;
        *) echo "Invalid option, try again." ;;
    esac
    echo
done
