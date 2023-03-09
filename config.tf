terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "y0_AgAAAAAQPnfPAATuwQAAAADeExK7EkFw1zMmQb6ZTYbmpmw_j60rPHs"
  cloud_id  = "b1g6n29jkok2srs36sqc"
  folder_id = "enp21oq1iip6h6dvmv21"
  zone      = "ru-central1-b"
}

data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "vm-test1" {
  name = "test1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }

}

# resource "yandex_vpc_network" "network_terraform" {
#   name = "net_terraform"
# }

# resource "yandex_vpc_subnet" "subnet_terraform" {
#   name           = "sub_terraform"
#   zone           = "ru-central1-a"
#   network_id     = yandex_vpc_network.network_terraform.id
#   v4_cidr_blocks = ["192.168.15.0/24"]
# }

# resource "yandex_compute_instance" "vm-1" {
#   name = "terraform1"

#   resources {
#     cores  = 2
#     memory = 2
#   }

#   boot_disk {
#     initialize_params {
#       image_id = "fd87va5cc00gaq2f5qfb"
#     }
#   }

#   network_interface {
#     subnet_id = yandex_vpc_subnet.subnet-1.id
#     nat       = true
#   }

#   metadata = {
#     ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
#   }
# }

# resource "yandex_compute_instance" "vm-2" {
#   name = "terraform2"

#   resources {
#     cores  = 4
#     memory = 4
#   }

#   boot_disk {
#     initialize_params {
#       image_id = "fd87va5cc00gaq2f5qfb"
#     }
#   }

#   network_interface {
#     subnet_id = yandex_vpc_subnet.subnet-1.id
#     nat       = true
#   }

#   metadata = {
#     ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
#   }
# }

# resource "yandex_vpc_network" "network-1" {
#   name = "network1"
# }

# resource "yandex_vpc_subnet" "subnet-1" {
#   name           = "subnet1"
#   zone           = "ru-central1-a"
#   network_id     = yandex_vpc_network.network-1.id
#   v4_cidr_blocks = ["192.168.10.0/24"]
# }

# output "internal_ip_address_vm_1" {
#   value = yandex_compute_instance.vm-1.network_interface.0.ip_address
# }

# output "internal_ip_address_vm_2" {
#   value = yandex_compute_instance.vm-2.network_interface.0.ip_address
# }


# output "external_ip_address_vm_1" {
#   value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
# }

# output "external_ip_address_vm_2" {
#   value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
# }