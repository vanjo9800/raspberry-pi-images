build {
  sources = [
    "source.arm-image.rpios-32-base",
    "source.arm-image.rpios-64-base",
  ]

  # Change default `pi` user password
  provisioner "shell" {
    inline = [
      "echo \"pi:${var.pi_password_hash}\" | chpasswd -e"
    ]
  }

  # Setup SSH access.
  provisioner "shell" {
    inline = [
      "mkdir ${var.user_home_dir}/.ssh",
    ]
  }
  provisioner "shell" {
    inline = ["touch /boot/ssh"]
  }
  provisioner "file" {
    content     = "${var.ssh_authorized_key}"
    destination = "${var.user_home_dir}/.ssh/authorized_keys"
  }
  # disable password authentication
  provisioner "shell" {
    inline = [
      "chown pi:pi ${var.user_home_dir}/.ssh/authorized_keys",
      "sed '/PasswordAuthentication/d' -i /etc/ssh/sshd_config",
      "echo >> /etc/ssh/sshd_config",
      "echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config",
    ]
  }

  # Setup WiFi
  provisioner "shell" {
    inline = [
      "wpa_passphrase \"${var.wifi_name[0]}\" \"${var.wifi_password[0]}\" | sed -e 's/#.*$//' -e '/^$/d' >> /etc/wpa_supplicant/wpa_supplicant.conf",
      "wpa_passphrase \"${var.wifi_name[1]}\" \"${var.wifi_password[1]}\" | sed -e 's/#.*$//' -e '/^$/d' >> /etc/wpa_supplicant/wpa_supplicant.conf",
    ]
  }

  # Update and install packages
  provisioner "shell" {
    inline = [
      "apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get upgrade -qqy",
      "DEBIAN_FRONTEND=noninteractive apt-get install -qqy git tmux vim"
    ]
  }
}
