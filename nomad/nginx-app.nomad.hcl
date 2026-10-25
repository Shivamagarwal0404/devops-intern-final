
job "nginx-app" {
  datacenters = ["dc1"]
  type        = "service"

  group "web" {
    count          =  1
    shutdown_delay = "5s"
      
    update {
      max_parallel     = 1
      min_healthy_time = "10s"
      healthy_deadline = "2m"
      auto_revert      = true
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "fail"
    }

    reschedule {
      attempts       = 5
      interval       = "1h"
      delay          = "30s"
      delay_function = "exponential"
      max_delay      = "5m"
      unlimited      = false
    }

    network {
      mode = "host"


      port "http" {
        static = 18080
        to     = 8080
      }
    }

    service {
      name     = "nginx-app"
      provider = "consul"
      port     = "http"
      address  = "127.0.0.1"

      check {
        name     = "nginx-health"
        type     = "http"
        path     = "/healthz"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "nginx" {
      driver = "docker"

      config {
        image = "ghcr.io/shivamagarwal0404/devops-intern-final:latest"
        ports = ["http"]
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}
