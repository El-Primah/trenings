resource "yandex_compute_instance" "vm" {
  name = "instance-${var.env}"
  zone = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8aus3bfglr6dg9hsbk"
      size     = 20
    }
  }

  network_interface {
    index     = 0
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    user-data = <<-EOF
    #cloud-config
    users:
      - name: user1
        groups: sudo
        shell: /bin/bash
        sudo: 'ALL=(ALL) NOPASSWD:ALL'
        ssh-authorized-keys:
          - ${var.ssh_key_file}
    
    package_update: true
    packages:
      - nginx
    
    write_files:
      - path: "/home/user1/startup.sh"
        permissions: "755"
        content: |
          #!/bin/bash

          export ip=$(curl ifconfig.me)

          sudo echo "<h1>Instance IP: $ip </h1><p>Hello from terragrunt</p>" > /var/www/html/index.html

          sudo nginx -s reload
        defer: true
    runcmd:
      - ["/home/user1/startup.sh"]
  EOF
  }
}