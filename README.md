# Ansible Portable

[![Builder](https://github.com/palazzem/ansible-portable/actions/workflows/builder.yaml/badge.svg?branch=main)](https://github.com/palazzem/ansible-portable/actions/workflows/builder.yaml)

This repository include a Docker image and a build script to prepare an Ansible archive
that can be used on any (Linux) host without installing any requirement.

To use it, download the latest package from the [release page][1] and run:

```bash
# Extracts Ansible in ansible-2.14.3/ folder and runs a test command
$ tar -xf ansible-2.14.3.tar.gz
$ PYTHONPATH=ansible-2.14.3 python ansible-2.14.3/ansible adhoc localhost -m ping
```

It outputs the Ansible task result:
```bash
localhost | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

Ansible Portable releases use the Ansible version so if you download the
`ansible-2.14.3.tar.gz` file, you are using Ansible version 2.14.3.

[1]: https://github.com/palazzem/ansible-portable/releases

### Use other Scripts

To use other scripts such as `ansible-playbook`, you need to create a symlink with
the script name:

```bash
$ cd ansible-2.14.3/
$ ln -s ansible ansible-playbook
```

## Requirements

Ansible Portable requires:
* `curl` to download the archive
* `tar` to extract the archive
* `python3` to execute Ansible

If you want to prepare the archive from your machine, you only need `docker` or `podman`.

## Build from Scratch

Ansible Portable provides a `Dockerfile` to build the archive directly from your
machine or CI environment. To use it, build the image and run it via:

```bash
$ git clone git@github.com:palazzem/ansible-portable.git
$ docker build -t ansible-builder .
$ docker run -ti --rm -v $PWD/builds:/builder/builds ansible-builder
```

After `docker` finishes, you can find the archive in the `builds/` directory.

## Update Ansible

If you want to update Ansible, it's enough to use `poetry`:

```bash
$ poetry update
```

## Contributing

We accept external contributions even though the project is mostly designed for
[personal needs](http://hanzo.sh). If you think the build system can be done better,
feel free to open a GitHub issue and to discuss your suggestion.

If you want to review the code and see what it does, you can check:
* `Dockerfile` that prepares an `archlinux/base` container with dependencies to
  prepare the archive
* `pyproject.toml` that includes what you are going to include in the archive
* `build.sh` that installs Ansible in a folder and prepares the archive in `builds/`
