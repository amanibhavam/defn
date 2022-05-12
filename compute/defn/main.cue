package imac

import (
	Compute "github.com/amanibhavam/defn/compute:k3d"
)

bootContext: Compute.#BootContext & {
	k3d_name:    "defn"
	k3d_host:    "defn.tiger-mamba.ts.net"
	k3d_ip:      "100.89.50.10"
	k3d_network: "host"
}
