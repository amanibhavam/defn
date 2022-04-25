package imac

import (
	Compute "github.com/amanibhavam/defn/compute/imac"
	App "github.com/amanibhavam/defn/admin"
)

bootContext: Compute.bootContext & {
	app: imac: App.#Admin
}
