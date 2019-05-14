# Ansible franklinkim.apache2 role

[![Build Status](https://img.shields.io/travis/weareinteractive/ansible-apache2.svg)](https://travis-ci.org/weareinteractive/ansible-apache2)
[![Galaxy](http://img.shields.io/badge/galaxy-franklinkim.apache2-blue.svg)](https://galaxy.ansible.com/list#/roles/1364)
[![GitHub Tags](https://img.shields.io/github/tag/weareinteractive/ansible-apache2.svg)](https://github.com/weareinteractive/ansible-apache2)
[![GitHub Stars](https://img.shields.io/github/stars/weareinteractive/ansible-apache2.svg)](https://github.com/weareinteractive/ansible-apache2)

> `franklinkim.apache2` is an [Ansible](http://www.ansible.com) role which:
>
> * installs apache2
> * configures apache2
> * enables/disables confs
> * creates sites
> * enables/disables sites
> * enables/disables modules
> * optionally removes default host
> * adds rules
> * configures service

## Installation

Using `ansible-galaxy`:

```shell
$ ansible-galaxy install franklinkim.apache2
```

Using `requirements.yml`:

```yaml
- src: franklinkim.apache2
```

Using `git`:

```shell
$ git clone https://github.com/weareinteractive/ansible-apache2.git franklinkim.apache2
```

## Dependencies

* Ansible >= 2.4

## Variables

Here is a list of all the default variables for this role, which are also available in `defaults/main.yml`.

```yaml
---
# apache2_packages:
#   - apache2
#   - apache2-mpm-prefork
# apache2_module:
#   - { id: auth, state: absent }
#   - { id: rewrite, state: present }
# apache2_confs:
#   - { id: security, state: absent }
#   - { name: mime, state: present }
# apache2_sites:
#   - id: mysite (required)
#     name: mysite.local (required)
#     ip: '*'
#     port: 80
#     state: present
#     add_webroot: no
#     template: path/to/template.j2
#     rules: []
#     aliases: []
#     redirects: []
#     ssl:
#       port: 443
#       key_name: mykey
#       cert_name: mycert
#       chain_name: mychain
#     auth:
#       name: mysite
#       file: mysite
#     append: ''
#

# packages (versions)
apache2_packages:
  - apache2
# ports to listen to
apache2_ports: [80]
# ssl ports to listen to
apache2_ssl_ports: [443]
# addresses to listen to (2.2  only)
apache2_listen_addresses: ['*']
# enabled/disabled modules
apache2_modules: []
# enabled/disabled confs
apache2_confs: []
# enabled/disabled sites
apache2_sites: []
# remove the default host
apache2_remove_default: no
# start on boot
apache2_service_enabled: yes
# current state: started, stopped
apache2_service_state: started
# set to one of:  Full | OS | Minimal | Minor | Major | Prod
apache2_server_tokens: Prod
# set to one of:  On | Off | EMail
apache2_server_signiture: 'Off'
# set to one of:  On | Off | extended
apache2_trace_enable: 'Off'
# path to certificates
apache2_certs_path: /etc/ssl/certs
# path to keys
apache2_keys_path: /etc/ssl/private

```

## Handlers

These are the handlers that are defined in `handlers/main.yml`.

```yaml
---

- name: restart apache2
  service: name=apache2 state=restarted
  when: apache2_service_state != 'stopped'

- name: reload apache2
  service: name=apache2 state=reloaded
  when: apache2_service_state != 'stopped'

```

## Rules

Some configuration fragments obtained from [HTML 5 Boilerplate](http://html5boilerplate.com/) will be copied to
`/etc/apache2/rules` which can then be used inside your vhost configurations (see usage below).

* compression
* content_transform
* cors
* cors_images
* cors_timing
* cors_web_fonts
* etag
* expires
* file_concatenation
* filename_based_cache_busting
* ie_cookies
* ie_edge
* mimes
* security_file_access
* security_hosts
* security_mime
* security_signiture
* security_technology
* ssl
* utf8

## Usage

This is an example playbook:

```yaml
---
# this examples uses related roles:
#
# - weareinteractive.apt  (https://github.com/weareinteractive/ansible-apt)
# - weareinteractive.openssl  (https://github.com/weareinteractive/ansible-openssl)
# - weareinteractive.htpasswd (https://github.com/weareinteractive/ansible-htpasswd)

- hosts: all
  become: yes
  roles:
    - weareinteractive.apt
    - weareinteractive.openssl
    - weareinteractive.htpasswd
    - franklinkim.apache2
  vars:
    htpasswd:
      - name: foobar
        users:
          - { name: foobar, password: foobar }
    apache2_modules:
      - { id: ssl, state: present }
      - { id: mime, state: present }
      - { id: headers, state: present }
      - { id: rewrite, state: present }
    apache2_remove_default: yes
    openssl_generate_csr: yes
    openssl_self_signed:
      - name: 'foobar.local'
        country: 'DE'
        state: 'Bavaria'
        city: 'Munich'
        organization: 'Foo Bar'
        unit: 'Foo Bar Unit'
        email: 'foo@bar.com'
    apache2_sites:
      - id: foobar
        state: present
        name: foobar.local
        rules:
          - mimes
          - expires
          - compression
        add_webroot: yes
        auth:
          name: Foo Bar
          file: foobar
        ssl:
          key_name: foobar.local
          cert_name: foobar.local

```


## Testing

```shell
$ git clone https://github.com/weareinteractive/ansible-apache2.git
$ cd ansible-apache2
$ make test
```

## Contributing
In lieu of a formal style guide, take care to maintain the existing coding style. Add unit tests and examples for any new or changed functionality.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

*Note: To update the `README.md` file please install and run `ansible-role`:*

```shell
$ gem install ansible-role
$ ansible-role docgen
```

## License
Copyright (c) We Are Interactive under the MIT license.
