variable "hcloud_token" {
}

variable "ssh_keys" {
  type = list(string)
}

# Optionals

variable "start" {
  default     = true
  description = "One of 'true' or 'false'. Start world immediately once installed"
}

variable "image" {
  default     = "debian-10"
  description = "The operating system to run. Scripts are specific to Debian so if you change this the project breaks"
}

variable "server_type" {
  # see: https://www.hetzner.com/cloud/#pricing
  default     = "cx21"
  description = "The size of the server, any smaller than 4GB memory crahes immediately when joining"
}

variable "location" {
  default     = "hel1"
  description = "Datacenter location can be one of: nbg1 (Nuremberg), fsn1 (Falkenstein) and hel1 (Helsinki)"
}

variable "name" {
  default     = "My Server"
  description = "Name that will be shown in the server browser"
}

variable "port" {
  default     = "2456"
  description = "UDP start port that the server will listen on"
}

variable "world" {
  default     = "Dedicated"
  description = "Name of the world without .db/.fwl file extension"
}

variable "password" {
  default     = "secret"
  description = "Password for logging into the server - min. 5 characters! Use only A-Z, a-z and 0-9."
}

variable "public" {
  default     = "1"
  description = "Whether the server should be listed in the server browser (1) or not (0)"
}
