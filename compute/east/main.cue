package east

import (
	Compute "github.com/amanibhavam/defn/compute:k3d"
)

bootContext: Compute.#BootContext & {
	k3d_name: "east"
	k3d_host: "east.tiger-mamba.ts.net"
	k3d_ip:   "100.101.28.35"
}
