package mbpro

import (
	Compute "github.com/amanibhavam/defn/compute:k3d"
)

bootContext: Compute.#BootContext & {
	k3d_name:    "mbpro"
	k3d_host:    "mbpro.defn.ooo"
	k3d_ip:      "100.90.96.49"
	k3d_network: "host"
}
