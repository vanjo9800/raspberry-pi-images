source "arm-image" "rpios-32-base" {
  iso_url         = "https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2022-04-07/2022-04-04-raspios-bullseye-armhf-lite.img.xz"
  iso_checksum    = "sha256:34987327503fac1076e53f3584f95ca5f41a6a790943f1979262d58d62b04175"
  output_filename = "../output-arm-image/rpios-32-base-${var.version}.img"
}
