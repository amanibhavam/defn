package east

import (
	Compute "github.com/amanibhavam/defn/compute/east"
	App "github.com/amanibhavam/defn/app/admin"
)

bootContext: Compute.bootContext & {
	app: east: App.#Admin
}
