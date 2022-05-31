# GPG Key Management

This guide was written as an aide memoire for creating, using, and maintaining GPG keys. Mostly it concerns itself with suggesting protocols for personal key management 

## Table of Contents

- [Introduction](#introduction)
- [Requirements](#requirements)
- [Generating Master Key](#generating-master-key)
- [Backing up Master Key](#backing-up-master-key)
	- [Exporting Master Key](#exporting-master-key)
	- [Manually Duplicating GPG Home Directory](#manually-duplicating-gpg-home-directory)

## Introduction

This is an introduction

## GPG Key Anatomy

## Requirements

TL;DR you will require:
- At least 3 forms of removeable media (most commonly USB drives/sticks)
- Access to an offline Linux system with GPG installed
- Access to this guide either downloaded offline or on some other system

## Generating Master Key

```bash
mkdir .gnupg
gpg --homedir .gnupg --full-generate-key --expert
```

Follow the prompts to generate your master key:

```gpg-shell
Please select what kind of key you want:
   	(1) RSA and RSA (default)
   	(2) DSA and Elgamal
   	(3) DSA (sign only)
   	(4) RSA (sign only)
   	(7) DSA (set your own capabilities)
   	(8) RSA (set your own capabilities)
   	(9) ECC and ECC
  	(10) ECC (sign only)
  	(11) ECC (set your own capabilities)
  	(13) Existing key
	(14) Existing key from card
Your selection? 8
```



```gpg-shell
Possible actions for a RSA key: Sign Certify Encrypt Authenticate
Current allowed actions: Sign Certify Encrypt

   (S) Toggle the sign capability
   (E) Toggle the encrypt capability
   (A) Toggle the authenticate capability
   (Q) Finished

Your selection? S
```



```gpg-shell
Possible actions for a RSA key: Sign Certify Encrypt Authenticate
Current allowed actions: Certify

   (S) Toggle the sign capability
   (E) Toggle the encrypt capability
   (A) Toggle the authenticate capability
   (Q) Finished

Your selection? Q
```

some text

```gpg-shell
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 291
Key expires at Sun Jan  1 01:22:54 2023 GMT
Is this correct? (y/N) y
```



```
Real name: John Doe
Email address: johndoe@mail.com
Comment: John Doe's universal GPG key
You selected this USER-ID:
    "John Doe (John Doe's universal GPG key) <johndoe@mail.com>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
```



## Backing up Master Key

Having generated your master key, it is now vitally important to make a backup of it. Obviously without the master key which is capable extending the validity of itself and its subkeys, your key becomes useless, therefore it is important that we do not loose access to the master key. 

Ideally any backups of the master key should be the only thing stored on the backup media, or only stored alongside other sensitive backups that should not touch online systems. That is to say that it is probably a bad idea to store a backup of the master key on a drive alongside family photos, since this will likely be inadvertently plugged into an online system, shared amongst family and friends, etc. 

Given the small size of GPG keys, this is an ideal use for smaller media that has less use for storing modern medias (I'm thinking of that stack of writeable CDs you haven't used, or even small memory cards which are no longer useful in modern digital cameras due to image file size). You should have at least one backup media, although preferably more than one, of more than one type stored in different locations if possible (for example one USB stick and one CD), the aim being solely to reduce the chances of completely loosing access to your master key.

### Exporting 

### Manually Duplicating GPG Home Directory

Although not recommended, you could of course copy the entire GPG home directory from the master media to the backup media. Whilst this will serve as a backup, it fails to differentiate between the backup media and the master key media .

## Exporting Subkeys

## Maintaining Master Key and Subkeys

### Extending Key Validity

### Managing Key IDs

### Revoking Master Key

### Revoking Subkeys

## Distributing Public Keys

## Using Subkeys

### Authenticate

### Encrypt

### Sign

## Configuring Git to Sign Commits

### Managing GitHub

## Useful Links

- http://irtfweb.ifa.hawaii.edu/~lockhart/gpg/
- https://risanb.com/code/backup-restore-gpg-key/



setting different passwords for master and subkeys, and using different password for subkeys each month
