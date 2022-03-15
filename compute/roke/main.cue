package roke

import (
	Compute "github.com/amanibhavam/defn/compute:k3d"
)

bootContext: Compute.#BootContext & {
	app: [aname=string]: app_name: aname

	k3d_name: "roke"
	k3d_host: "roke.defn.ooo"
	k3d_ip:   "100.101.28.35"
}
