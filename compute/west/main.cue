package west

import (
	Compute "github.com/amanibhavam/defn/compute:k3d"
)

bootContext: Compute.#BootContext & {
	k3d_name: "west"
	k3d_host: "west.defn.ooo"
	k3d_ip:   "100.101.28.35"
}
