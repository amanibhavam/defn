package imac

import (
	Compute "github.com/amanibhavam/defn/compute:k3d"
)

bootContext: Compute.#BootContext & {
	k3d_name:    "imac"
	k3d_host:    "imac.tiger-mamba.ts.net"
	k3d_ip:      "100.119.206.78"
	k3d_network: "host"
}
