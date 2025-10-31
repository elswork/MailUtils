# MailUtils

A [Docker](http://docker.com) file to build an image with `mailutils` and `ssmtp` to send emails.

## Details

| Website | GitHub | Docker Hub |
| --- | --- | --- |
| [Deft.Work my personal blog](https://deft.work) | [MailUtils](https://github.com/elswork/MailUtils) | [MailUtils](https://hub.docker.com/r/elswork/MailUtils) |

| Docker Pulls | Docker Stars | Size | Sponsors |
| --- | --- | --- | --- |
| [![Docker pulls](https://img.shields.io/docker/pulls/elswork/MailUtils.svg)](https://hub.docker.com/r/elswork/MailUtils "MailUtils on Docker Hub") | [![Docker stars](https://img.shields.io/docker/stars/elswork/MailUtils.svg)](https://hub.docker.com/r/elswork/MailUtils "MailUtils on Docker Hub") | [![Docker Image size](https://img.shields.io/docker/image-size/elswork/MailUtils)](https://hub.docker.com/r/elswork/MailUtils "MailUtils on Docker Hub") | [![GitHub Sponsors](https://img.shields.io/github/sponsors/elswork)](https://github.com/sponsors/elswork "Sponsor me!") |

## Compatible Architectures

This image has been built and tested using [buildx](https://docs.docker.com/buildx/working-with-buildx/) for these architectures: 
- amd64 arm64 arm/v7

## Build Instructions

``` sh
docker build -t elswork/mail-sender .
```

## Usage

### Build the image

``` sh
make build
```

### Run the container

``` sh
make run
```

### Send a test email

``` sh
make send-test-mail
```

### Stop the container

``` sh
make stop
```

### Remove the container

``` sh
make rm
```

## Shell Aliases and Functions

You can add the following aliases and functions to your `.bashrc`, `.zshrc` or similar shell configuration file to easily send emails from your command line.

**Note:** These examples assume your container is named `my-mail-sender` and your email is `your-email@example.com`. Remember to change them to match your configuration.

### Send command history (`mh`)

This alias, named `mh` (for "mail history"), sends your shell's command history to your email.

```sh
alias mh="history | docker exec -i my-mail-sender mail -s \"\$(whoami) \$(uname -nr) \$(awk -F= '\$1==\"PRETTY_NAME\" { print \$2 ;}' /etc/os-release)\" your-email@example.com"
```

### Send command output (`mailme`)

This shell function, named `mailme`, allows you to send the output of any command to your email.

```bash
mailme() {
  if [ -z "$1" ]; then
    echo "Usage: mailme <command>"
    echo "Example: mailme ls -l"
    return 1
  fi

  # The subject includes the command name ($1) for clarity
  SUBJECT="Output of command: $1"
  
  "$@" | docker exec -i my-mail-sender mail -s "$SUBJECT" your-email@example.com
}
```

**Usage examples:**

```sh
# Send the content of a file
mailme cat /path/to/your/file.txt

# Send the list of running processes
mailme ps aux
```

## Funding and Donations

**[Sponsor me!](https://github.com/sponsors/elswork) Together we will be unstoppable.**

Other ways to fund me:

[![GitHub Sponsors](https://img.shields.io/github/sponsors/elswork)](https://github.com/sponsors/elswork) [![Donate PayPal](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/donate/?business=LFKA5YRJAFYR6&no_recurring=0&item_name=Open+Source+Donation&currency_code=EUR) 
---

**Donate with Bitcoin (BTC):**

`bc1qfxsxxcr2akh2l26m6am0vpwwkhnsua04lmgfef`

[View on Blockchain.com](https://www.blockchain.com/btc/address/bc1qfxsxxcr2akh2l26m6am0vpwwkhnsua04lmgfef)

---

**Donate with Ethereum (ETH):**

`0x186b91982CbB6450Af5Ab6F32edf074dFCE8771c`

[View on Etherscan](https://etherscan.io/address/0x186b91982CbB6450Af5Ab6F32edf074dFCE8771c)

---

*Please note that donations are voluntary and non-refundable. Thank you for your generosity!*
