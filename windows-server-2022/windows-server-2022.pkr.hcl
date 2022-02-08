variable "iso_checksum" {
  type    = string
  default = "none"
}

variable "iso_url" {
  type    = string
  default = "https://software-download.microsoft.com/download/sg/20348.169.210806-2348.fe_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso"
}

variable "winrm_password" {
  type    = string
  default = "vagrant"
}

variable "winrm_username" {
  type    = string
  default = "vagrant"
}

source "virtualbox-iso" "image" {
  boot_wait            = "2m"
  communicator         = "winrm"
  disk_size            = "40960"
  floppy_files         = ["./files/autounattend.xml", "./files/unattend.xml", "./files/sysprep.bat", "./files/enable-winrm.ps1"]
  guest_additions_mode = "disable"
  guest_os_type        = "Windows2022_64"
  headless             = true
  iso_checksum         = "${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
  shutdown_command     = "a:/sysprep.bat"
  vboxmanage           = [["modifyvm", "{{ .Name }}", "--memory", "2048"], ["modifyvm", "{{ .Name }}", "--cpus", "2"]]
  vm_name              = "server-2022"
  winrm_password       = "${var.winrm_password}"
  winrm_timeout        = "4h"
  winrm_username       = "${var.winrm_username}"
}

build {
  sources = ["source.virtualbox-iso.image"]

  provisioner "powershell" {
    script = ".\\files\\install-updates.ps1"
    elevated_user = "${var.winrm_username}"
    elevated_password = "${var.winrm_password}"
    timeout = "3h"
  }

  provisioner "windows-restart" {
    restart_timeout = "1h"
  }

  provisioner "powershell" {
    script = ".\\files\\install-updates.ps1"
    elevated_user = "${var.winrm_username}"
    elevated_password = "${var.winrm_password}"
    timeout = "3h"
  }

  provisioner "windows-restart" {
    restart_timeout = "1h"
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "../server-2022.box"
  }
}
