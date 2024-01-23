terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
    }
  }
}

provider "docker" {
  host = "ssh://eko@192.168.0.150"
  ssh_opts = [
     "-p", 2222,
     "-i", "C:\\Users\\eva.kopalova\\.ssh\\from_rb_pi_rsa",
     "-o", "IdentitiesOnly=yes",
     "-o", "UserKnownHostsFile=/dev/null",
     "-o", "StrictHostKeyChecking=no",
     "-o", "LogLevel=ERROR",
     "-o", "PreferredAuthentications=publickey"
   ]
  //ssh_opts = ["-P", "2222", "-i", "C:\\Users\\eva.kopalova\\.ssh\\from_rb_pi_rsa", "-o", "IdentitiesOnly=yes", "-o", "UserKnownHostsFile=/dev/null", "-o", "StrictHostKeyChecking=no", "-o", "LogLevel=ERROR", "-o", "PreferredAuthentications=publickey", "-o", "IdentityFile=C:\\Windows\\System32\\OpenSSH\\ssh.exe"]

  //ssh_opts = ["-i", "C:\\Users\\eva.kopalova\\.ssh\\from_rb_pi_rsa"]
  //ssh_opts = ["-P", "2222", ""]

}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "nginx-container"
  ports {
    internal = 80
    external = 8080
  }
}
