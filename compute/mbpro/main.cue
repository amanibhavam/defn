package mbpro

import (
	Compute "github.com/amanibhavam/defn/compute:k3d"
)

bootContext: Compute.#BootContext & {
	k3d_name:    "mbpro"
	k3d_host:    "mbpro.tiger-mamba.ts.net"
	k3d_ip:      "100.106.172.56"
	k3d_network: "host"
}
