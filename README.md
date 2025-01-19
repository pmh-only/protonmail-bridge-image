# :package: `protonmail-bridge-image`
Automatically build container images for ProtonMail SMTP/IMAP bridge 

*powered by Github Actions.

## Warnings!
* This image doesn't support keychain storage all mails will be stored as plaintext.
* The SMTP/IMAP servers will listening at 0.0.0.0 host. This is an intended behavior to reach from outside of container.
* Your SMTP/IMAP consumer must ignore self-signed certificate.

## How to use
### 1. Open interactive shell
First run below command to access interactive shell for initialize account \
(Ignore errors and warnings after run. this image doesn't support keychain storage)
```sh
docker run -itv .:/data ghcr.io/pmh-only/protonmail-bridge -c
```

### 2. Provide ProtonMail credentials
In ProtonMail interactive shell, type `login` and provide ProtonMail credentials.

After that, the ProtoMail Interactive Shell will download your mail content.\
However, you don't have to wait for the sync to complete. Downloads will continue automatically after the setup is complete

### 3. Get connection infos
Type `info` in the ProtonMail interactive shell. This will show you SMTP and IMAP credentials which you need.

If you finished saving those credentials. you can type `exit` to escape from interactive shell

### 4. Run as a daemon
Setup is finished. You can now run ProtonMail SMTP/IMAP bridge as a daemon!
```sh
docker run -dp 1143:1143 -p 1025:1025 -v .:/data ghcr.io/pmh-only/protonmail-bridge
```
