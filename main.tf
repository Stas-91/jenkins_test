terraform {
    required_providers {
        yandex = {
            source = "yandex-cloud/yandex"
        }
    }
}

provider "yandex" {
  token                    = var.token
  cloud_id                 = "b1g8ta6qu7na0ir2khnv"
  folder_id                = "b1g8kve3609ag8bp327e"
}

variable "token" {
  type = string
}

variable "ssh_public_key" { 
  type = string
}

resource "yandex_compute_instance" "test1" {
  name = "test1"
  zone = "ru-central1-a"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
      size = 10
      type = "network-ssd"
    }
  }
  network_interface {
    subnet_id = "e9bab1n890lkhh5rnjg5"
    nat       = true
  }

  scheduling_policy {
    preemptible = true        # Указание, что ВМ прерываемая
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}
