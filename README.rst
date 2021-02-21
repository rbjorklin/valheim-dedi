Valheim Dedicated Server
========================

.. contents:: :local:

Introduction
============
Let's start with getting the boring bit out of the way. I take absolutely no responsibility for what happens to your world and 
by using this you accept that you will incur costs for running the server.

I created this automation in an attempt to let more people enjoy Valheim with their friends. Enjoy!

Getting Started
===============

Prerequisites
-------------

* If you're on Windows you're probably going to need WSL2_
* This project uses Terraform_ to provision a server and handle the installation so you need to install it.
* I decided to use Hetzner_ as a hosting provider as they are about as cheap as they come. You will need an account with them.
* Once all of the above has been setup an ssh key is needed. This can be done by executing ``ssh-keygen`` in a shell.
* The ssh key created in the previous step needs to be uploaded to your Hetzner account.
* An API Token also needs to be created through the Hetzner Web UI.

Actually installing the server
------------------------------

With all of the above in place copy the example.tfvars_ file and make changes as necessary. There is a descripiton of the
different options in variables.tf_.

To install and start the server with a new world make sure ``start = true`` and then run:

::

  terraform init
  terraform apply -var-file <your-vars>.tfvars


Uploading a pre-created world
=============================

Before running ``terraform apply`` make sure to change ``start`` to ``false``.
To upload your own world you can use ``scp`` or Filezilla_ and upload your world files to ``/opt/valheim``.
Once the upload has completed make sure to change ``start = true`` and re-run terraform.

Updating the server
===================

Occasionally you should update the server software. This can be achieved easily by doing:

::

  terraform taint 'null_resource.start[0]'
  terraform apply -var-file <your-vars>.tfvars

How do I delete my server and make this thing stop costing me money?
====================================================================

::

  terraform destroy -var-file <your-vars>.tfvars

.. _Filezilla: https://filezilla-project.org/
.. _WSL2: https://www.windowscentral.com/how-install-wsl2-windows-10
.. _Terraform: https://www.terraform.io/downloads.html
.. _Hetzner: https://www.hetzner.com/
.. _example.tfvars: example.tfvars
.. _variables.tf: variables.tf
