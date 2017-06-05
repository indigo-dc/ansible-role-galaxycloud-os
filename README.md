ansible-role-galaxycloud-os
=========

Storage configuration for indigo-dc.galaxycloud ansible role.

1. IaaS ---------> IaaS block storage volume is attached
2. onedata ------> OneData volume is mounted
3. encryption ---> IaaS block storage volume encrypted with AES is mounted

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
