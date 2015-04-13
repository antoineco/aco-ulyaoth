#ulyaoth

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
4. [Usage](#usage)
5. [Credits](#credits)

##Overview

The ulyaoth module installs the Ulyaoth YUM repository on all [RHEL variants](http://en.wikipedia.org/wiki/List_of_Linux_distributions#RHEL-based) including Fedora.

##Module description

The [Ulyaoth](https://community.ulyaoth.net/threads/ulyaoth-repositories.3/) repository contains up-to-date versions of some popular server programs such as Tomcat and Nginx, as well as other tools like Logstash-Forwarder and Kibana, packaged in the RPM-format. For a list of available packages please check the [project's GitHub](https://github.com/sbagmeijer/ulyaoth/tree/master/Repository) and the dedicated [community forums](https://community.ulyaoth.net/forums/repository/).

This module is suitable for systems which use the YUM package manager, ie. RHEL variants, and for the x86_64 architecture only.

##Setup

ulyaoth will affect the following parts of your system:

* Ulyaoth YUM repositories
* Ulyaoth GPG key

Including the main class is enough to get started. It will install the Ulyaoth repository as described above.

```puppet
include ::ulyaoth
```

####A couple of examples

Disable the GPG signature check

```puppet
class { '::ulyaoth':
  …
  gpgcheck => 0
}
```

##Usage

####Class: `ulyaoth`

Primary class and entry point of the module.

**Parameters within `ulyaoth`:**

#####`gpgcheck`

Switch to perform or not GPG signature checks on repository packages. Defaults to `1`

#####`enable`

Enable repository. Defaults to `1`

##Credits

The `rpm_gpg_key` defined type was reused from the ['epel' module by Michael Stahnke](https://forge.puppetlabs.com/stahnma/epel) (stahnma).  
The repository is maintained by [Sjir Bagmeijer](https://github.com/sbagmeijer).

Features request and contributions are always welcome!
