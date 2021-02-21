terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.24.1"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_server" "node" {
  name        = "valheim"
  image       = var.image
  server_type = var.server_type
  location    = var.location
  ssh_keys    = var.ssh_keys
}

resource "hcloud_volume" "main" {
  server_id = hcloud_server.node.id
  name      = "valheim"
  size      = 10
  format    = "xfs"
  automount = true
}

resource "null_resource" "install" {
  connection {
    host = hcloud_server.node.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [templatefile("deploy.sh", {
      device = hcloud_volume.main.linux_device,
    })]
  }
}

resource "null_resource" "start" {
  count = var.start ? 1 : 0

  connection {
    host = hcloud_server.node.ipv4_address
  }

  provisioner "file" {
    content = templatefile("valheim.service", {
      NAME     = var.name,
      WORLD    = var.world,
      PASSWORD = var.password,
      PUBLIC   = var.public,
      PORT     = var.port,
    })
    source      = "valheim.service"
    destination = "/etc/systemd/system/valheim.service"
  }

  provisioner "file" {
    content     = templatefile("Dockerfile", { date = timestamp() })
    destination = "/opt/valheim/Dockerfile"
  }

  provisioner "remote-exec" {
    inline = ["chown -R valheim: /opt/valheim", "systemctl daemon-reload", "systemctl restart valheim"]
  }
}
