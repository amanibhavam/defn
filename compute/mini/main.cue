package mini

import (
	Compute "github.com/amanibhavam/defn/compute:k3d"
)

bootContext: Compute.#BootContext & {
	k3d_name: "mini"
	k3d_host: "mini.defn.ooo"
	k3d_ip:   "100.90.96.49"
}