resource "yandex_lb_network_load_balancer" "nlb" {
  name = "nlb-${var.env}"

  listener {
    name = "http-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.target-group.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}


resource "yandex_lb_target_group" "target-group" {
  name      = "${var.env}-tg"
  region_id = var.region

  target {
    subnet_id = var.subnet_id
    address   = var.instance_ip
  }
}