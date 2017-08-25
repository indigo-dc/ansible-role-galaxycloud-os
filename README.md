indigo-dc.galaxycloud-os
========================
This role provides advanced storage options for Galaxy instances.

Run indigo-dc.galaxycloud-os before indigo-dc.galaxycloud, setting the variable ``enable_storage_advanced_options`` to ``true``.

It is possible to select three different storage options using the ``os_storage`` ansible role variable.

====================  =========================
Storage provider      Description   
====================  =========================
Iaas                  IaaS block storage volume is attached to the instance and Galaxy is configured.
onedata               Onedata space is mounte through oneclient and Galaxy is configured.
encryption            IaaS block storage volume is encrypted with aes-xts-plain64 algorithm using LUKS.
====================  =========================

Path configuration for Galaxy is then correctly set, depending on the storage solution selected, replacing the indigo-dc.galaxycloud path recipe (with the ``enable_storage_advanced_options`` set to ``true``).

The role exploits the ``galaxyctl_libs`` (see :doc:`script_galaxyctl_libs`) for LUKS and onedata volumes management .


Dependencies
------------

The indigo-dc.oneclient role is installed if 'os_storage' is set to 'onedata'

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: localhost
      connection: local
      roles:
        - { role: galaxycloud-os, GALAXY_ADMIN_EMAIL: "{{ galaxy_admin_mail }}", os_storage: "encryption", galaxy_instance_key_pub: "{{ galaxy_instance_key_pub }}" }

License
-------

Apache Licence v2

http://www.apache.org/licenses/LICENSE-2.0

Author Information
------------------

Marco Tanagaro (ma.tangaro_at_ibbe.cnr.it)
