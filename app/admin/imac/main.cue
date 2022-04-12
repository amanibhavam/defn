package imac

import (
	Compute "github.com/amanibhavam/defn/compute/imac"
	App "github.com/amanibhavam/defn/app/admin"
)

bootContext: Compute.bootContext & {
	app: imac: App.#Admin
}
