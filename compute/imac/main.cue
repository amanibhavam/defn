package imac

import (
	Compute "github.com/amanibhavam/defn/compute:k3d"
)

bootContext: Compute.#BootContext & {
	k3d_name:    "imac"
	k3d_host:    "imac.defn.ooo"
	k3d_ip:      "100.90.96.49"
	k3d_network: "host"
}
