package east

import (
	Compute "github.com/amanibhavam/defn/compute/east"
	App "github.com/amanibhavam/defn/admin"
)

bootContext: Compute.bootContext & {
	app: east: App.#Admin
}
