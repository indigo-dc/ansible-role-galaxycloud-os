indigo-dc.galaxycloud-os
========================
This role provides storage encryption with aes-xts-plain64 algorithm using LUKS for Galaxy instances.

Run indigo-dc.galaxycloud-os before indigo-dc.galaxycloud, setting the variable ``enable_storage_advanced_options`` to ``true``. Path configuration for Galaxy is then correctly provided, replacing the indigo-dc.galaxycloud path recipe.

The role exploits the [luksctl](https://github.com/Laniakea-elixir-it/luksctl) script and [luksctl_api](https://github.com/Laniakea-elixir-it/luksctl_api) for LUKS volumes management .

LUKS encryption
---------------
For a detailed description of LUKS encryption used and scripts, see the [Laniakea encryption documentation](https://laniakea.readthedocs.io/en/latest/admin_documentation/encryption/encryption.html)

Dependencies
------------

For LUKS encryption the ansible role install ``cryptsetup``.

Variables
---------
The Galaxy path variables are the same of indigo-dc.galaxycloud.

### Path ###

``galaxy_user``: set linux user to launch the Galaxy portal (default: ``galaxy``).

``GALAXY_UID``: set user UID (default: ``4001``).

``galaxy_FS_path``: path to install Galaxy (default: ``/home/galaxy``).

``galaxy_directory``: Galaxy directory (usually galaxy or galaxy-dist, default ``galaxy``).

``galaxy_install_path``: Galaxy installation directory (default: ``/home/galaxy/galaxy``).

``export_dir``: Galaxy userdata are stored here (defatult: ``/export``).

``galaxy_custom_config_path``: Galaxy custom configuration files path (default: ``/etc/galaxy``).

``galaxy_custom_script_path``: Galaxy custom script path (defautl: ``/usr/local/bin``).

``galaxy_log_path``: log file directory (default: ``/var/log/galaxy``).

``galaxy_instance_key_pub``: instance ssh public key to configure <galaxy_user> access.

``galaxy_lrms``: enable  Galaxy virtual elastic cluster support. Currently supported local and slurm (default: ``local``, possible values: ``local, slurm``).

``type_of_node``: node type for api cluster configuration. ``front`` is executed for single VMs and cluster front node. ``wn`` is executed only on cluster WNs default: ``front``)

``wn_ips``: list of IPs of the WNs(default: [])

``application_virtualization_type``: if the application, e.g. Galaxy, running on encrypted storage, is dockerized, docker needs to be restarted. Set ``docker``if needed. (default: 'vm').

### Main options ###

``GALAXY_ADMIN_EMAIL``: Galaxy administrator e-mail address

### Encryption ###

``storage_encryption``: enable storage encryption (default: ``False``)

``luks_lock_dir``: set luks lock file directory (default: ``/var/run/fast_luks``).

``luks_success_file``: set success file. It signals to ansible to proceed (default: ``/var/run/fast-luks.success``).

``volume_setup_success_file``: set success file. It signals to ansible to proceed (default: ``/var/run/fast-luks-volume-setup.success``)

``luks_log_path``: set LUKS log path (default: ``/var/log/galaxy``).

``luks_config_path``: set LUKS configuration file path (default: ``/etc/luks``).

``luks_config_file``: set luksctl configuration file (default: ``/etc/galaxy/luks-cryptdev.ini``).

``wait_timeout``: time to waint encryption password (default: 5 hours).

``fast_luks_repository``: LUKS script to perform encryption repository (``https://github.com/Laniakea-elixir-it/fast-luks.git``).
``fast_luks_version``: LUKS script to perform encryption version (``v3.0.2``).

Create block file:

https://wiki.archlinux.org/index.php/Dm-crypt/Device_encryption

https://wiki.archlinux.org/index.php/Dm-crypt/Drive_preparation

https://wiki.archlinux.org/index.php/Disk_encryption#Preparing_the_disk

Before encrypting a drive, it is recommended to perform a secure erase of the disk by overwriting the entire drive with random data.

To prevent cryptographic attacks or unwanted file recovery, this data is ideally indistinguishable from data later written by dm-crypt.

``paranoid_mode``: to enable block storage low level deletion set to true (default: ``false``).

### LUKS specific variables ###

``cipher_algorithm``: set cipher algorithm (default: ``aes-xts-plain64``).

``keysize``: set key size (default: ``256``).

``hash_algorithm``: set hash algorithm (default: ``sha256``).

``device``: set device to mount (default: ``/dev/vdb``)

``cryptdev``: set device mapper name (default:  ``/dev'crypt``).

``mountpoint``: set mount point. Usually the same of ``export_dir`` (default:  ``{{ export_dir }}``).

``filesystem``: set file system (default: ``ext4``).

### Hashicorp Vault support ###

``vault_url``: Hashicorp Vault url.

``vault_wrapping_token``: Vault wrapping token, used to write the user secret passphrase on Vault

``vault_secret_path``: Vault path of the passphrase.

``vault_secret_key``: Vault key name of the passphrase.

### Final configuration ###

``enable_reboot_scripts``: configure reboot scripts. (default: ``true``).

``enable_customization_scripts``: configure check_instance script. Currently docker is not supported, set to false. (default ``true``).

Example Playbook
----------------

Plain configuration:

```yaml
  - hosts: servers
    roles:
      - role: indigo-dc.galaxycloud-os
        storage_encryption: false
        GALAXY_ADMIN_EMAIL: "admin@server.com"
        galaxy_instance_key_pub: '<your_ssh_public_key>'

      - role: indigo-dc.galaxycloud
        GALAXY_ADMIN_EMAIL: "admin@server.com"
        GALAXY_ADMIN_USERNAME: "admin"
        GALAXY_VERSION: "release_17.05"
        galaxy_instance_key_pub: "<your_ssh_public_key>"
        enable_storage_advanced_options: true
```

LUKS configuration:

```yaml
  - hosts: servers
    roles:
      - role: indigo-dc.galaxycloud-os
        storage_encryption: true
        GALAXY_ADMIN_EMAIL: "admin@server.com"
        galaxy_instance_key_pub: '<your_ssh_public_key>'

      - role: indigo-dc.galaxycloud
        GALAXY_ADMIN_EMAIL: "admin@server.com"
        GALAXY_ADMIN_USERNAME: "admin"
        GALAXY_VERSION: "release_17.05"
        galaxy_instance_key_pub: "<your_ssh_public_key>"
        enable_storage_advanced_options: true
```

License
-------

Apache Licence v2: http://www.apache.org/licenses/LICENSE-2.0

Author Information
------------------

Marco Tanagaro (ma.tangaro_at_ibiom.cnr.it)
