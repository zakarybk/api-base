# C# Mono only branch of Judge0 API-BASE

## Installation
* git clone https://github.com/zakarybk/api-base.git -b 1.0.0-mono-only
* cd api-base
* sudo docker build -t judge0/api-base:1.0.0-mono-only .

# Judge0 API Base
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://github.com/judge0/api-base/blob/master/LICENSE)
[![Become a Patron](https://img.shields.io/badge/Donate-Patreon-orange)](https://www.patreon.com/hermanzdosilovic)
[![Donate with PayPal](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/hermanzdosilovic)

## About
**Judge0 API Base** is an base API Docker image with installed compilers, interpreters and sandbox environment - [isolate](https://github.com/ioi/isolate).

## Compilers and Interpreters
Each compiler and interpreter is compiled during image build, or if precompiled binary was available for x86_64 architecture then this binary is used.

We used this approach of compiling each compiler and interpreter instead of installing available packages because we have full control of choosing where this compiler and interpreter will be installed. That also gives us ability to install some compilers and interpreters that are not available with package manager.

As a consequence, Judge0 API Base image is large and build time takes few hours, but we successfully installed many different compilers and interpreters and more of them can be added easily.

We are open to any suggestions on how to reduce size of this image but retain flexibility of adding/removing new compilers and interpreters.

Here is a list of supported languages:

|#|Name|
|:---:|:---:|
|1|C# (Mono 6.6.0.161)|

## Sandbox Environment
Sandbox environment is also included in this image. For sandbox environment we are using [isolate](https://github.com/ioi/isolate) (licensed under [GPL v2](https://github.com/ioi/isolate/blob/master/LICENSE)).

>Isolate is a sandbox built to safely run untrusted executables, offering them a limited-access environment and preventing them from affecting the host system. It takes advantage of features specific to the Linux kernel, like namespaces and control groups.

Huge thanks to [Martin Mareš](https://github.com/gollux) and [Bernard Blackham](https://github.com/bblackham) for developing and maintaining this project. Also, thanks to all other people who contributed to isolate project.

Isolate was used as sandbox environment (part of [CMS](https://github.com/cms-dev/cms) system) on big programming contests like [International Olympiad in Informatics](http://www.ioinformatics.org/index.shtml) (a.k.a. IOI) in 2012, and we trust that this sandbox environment works and does its job.

## Building Docker Image
If you want to build your own Judge0 API Base image:

1. Clone or download this project.
2. Make changes if you want.
3. Run `docker build -t yourRepoName .`
4. Grab some coffee, this **will** take some time.

## Pulling Docker Image
Take a look at [Docker Hub](https://hub.docker.com/r/judge0/api-base/tags/). There are version tags and `latest` tag.

`latest` tag will always be equal to highest version tag. Dockerfiles for all versions will be available in [tags](https://github.com/judge0/api-base/tags) or [releases](https://github.com/judge0/api-base/releases) pages of GitHub.

To pull version `1.0.0`:

1. `docker pull judge0/api-base:1.0.0`
2. Grab some coffee, this **might** take a while.

## Adding New Compiler or Interpreter
Adding new compiler or interpreter is easy as long as you know how to compile it properly or as long as you know what precompiled binary you need to download.

You should add installation of your favorite compiler between installation of last compiler and isolate installation. Installation of isolate should always be the last, because it is then easier to rebuild image when new version of isolate is available.

You should also install your favorite compiler inside `/usr/local/` folder. For example `GCC 9.2.0` is installed inside `/usr/local/gcc-9.2.0` folder.

Please note that when you add new compiler or interpreter there is still some work that needs to be done for it to be usable on [**Judge0 API**](https://api.judge0.com), but adding it to Judge0 API Base image is the first step. After that read documentation of [Judge0 API](https://github.com/judge0/api) for the next steps.

## Donate
Your are more than welcome to support Judge0 on [Patreon](https://www.patreon.com/hermanzdosilovic) or via [PayPal](https://www.paypal.me/hermanzdosilovic). Your monthly or one-time donation will help pay server costs and will improve future development and maintenance. Thank you ♥
