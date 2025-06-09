resource "yandex_vpc_network" "test_network" {
  name = var.env
}

resource "yandex_vpc_subnet" "test_subnet" {
  name           = "${var.env}-subnet-a"
  zone           = var.zone
  network_id     = yandex_vpc_network.test_network.id
  v4_cidr_blocks = [var.cidr_block]
}
