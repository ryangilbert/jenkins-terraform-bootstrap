#cloud-config

package_update: true
package_upgrade: true

apt:
  sources:
    docker.list:
      source: "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
      keyid: 0EBFCD88

packages:
  - docker-ce

power_state:
  delay: "Now"
  mode: reboot
  message: Reboot after installing Docker
  condition: True
