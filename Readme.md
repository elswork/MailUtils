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

This image has been builded using [buildx](https://docs.docker.com/buildx/working-with-buildx/) for these architectures: 
- amd64 arm64 ppc64le s390x 386 arm/v7 arm/v6

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

#### ☕ ¿Quieres apoyar mi trabajo?

**[¡Patrocíname!](https://github.com/sponsors/elswork) Juntos seremos imparables.**

Otras formas de financiarme:

[![GitHub Sponsors](https://img.shields.io/github/sponsors/elswork)](https://github.com/sponsors/elswork)
[![Donar PayPal](https://img.shields.io/badge/Donar-PayPal-green.svg)](https://www.paypal.me/elswork)

---

**Donar con Bitcoin (BTC):**
`bc1qfxsxxcr2akh2l26m6am0vpwwkhnsua04lmgfef`  
[Ver en Blockchain.com](https://www.blockchain.com/btc/address/bc1qfxsxxcr2akh2l26m6am0vpwwkhnsua04lmgfef)

**Donar con Ethereum (ETH):**
`0x186b91982CbB6450Af5Ab6F32edf074dFCE8771c`  
[Ver en Etherscan](https://etherscan.io/address/0x186b91982CbB6450Af5Ab6F32edf074dFCE8771c)

*Ten en cuenta que las donaciones son voluntarias y no son reembolsables. ¡Gracias por tu generosidad!*
