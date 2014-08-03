# Ansible Apache2 Role

[![Build Status](https://travis-ci.org/weareinteractive/ansible-role-apache2.png?branch=master)](https://travis-ci.org/weareinteractive/ansible-role-apache2)
[![Stories in Ready](https://badge.waffle.io/weareinteractive/ansible-role-apache2.svg?label=ready&title=Ready)](http://waffle.io/weareinteractive/ansible-role-apache2)

> `apache2` is an [ansible](http://www.ansible.com) role which: 
> 
> * installs apache2
> * configures apache2
> * configures `/var/www`
> * enables/disables confs
> * enables/disables sites
> * enables/disables modules
> * optionally removes default host

## Installation

Using `ansible-galaxy`:

```
$ ansible-galaxy install franklinkim.apache2
```

Using `arm` ([Ansible Role Manager](https://github.com/mirskytech/ansible-role-manager/)):

```
$ arm install franklinkim.apache2
```

Using `git`:

```
$ git clone https://github.com/weareinteractive/ansible-role-apache2.git
```

## Variables

```
# apache2_module:
#   - { id: auth, state: absent }
#   - { id: rewrite, state: present }
# apache2_confs:
#   - { id: security, state: absent }
#   - { id: mime, state: present }
# apache2_sites:
#   - { id: default, state: absent }
#   - { id: foobar, state: present }
#

# ports to listen to
apache2_ports: [80]
# ssl ports to listen to
apache2_ssl_ports: [443]
# enabled/disabled modules
apache2_modules: []
# enabled/disabled confs
apache2_confs: []
# enabled/disabled sites
apache2_sites: []
# www dir owner name
apache2_wwww_dir_owner: root
# www dir group name
apache2_wwww_dir_group: root
# www dir mode
apache2_wwww_dir_mode: 0775
# remove the default host
apache2_remove_default: yes
# start on boot
apache2_service_enabled: yes
# current state: started, stopped
apache2_service_state: started
```

## Example playbook

```
- host: all
  roles: 
    - franklinkim.apache2
  vars:
    apache2_confs:
      - { id: charset, state: absent }
      - { id: serve-cgi-bin, state: absent }
      - { id: localized-error-pages, state: absent }
      - { id: security, state: present }
    apache2_modules:
      - { id: mime, state: present }
      - { id: headers, state: present }
      - { id: rewrite, state: present }
    apache2_wwww_dir_owner: staff
    apache2_wwww_dir_group: staff
    apache2_wwww_dir_mode: 4775
```

## Testing

```
$ git clone https://github.com/weareinteractive/ansible-role-apache2.git
$ cd ansible-role-apache2
$ vagrant up
```

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests and examples for any new or changed functionality.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
Copyright (c) We Are Interactive under the MIT license.
