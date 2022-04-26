package west

import (
	Compute "github.com/amanibhavam/defn/compute/west"
	App "github.com/amanibhavam/defn/admin"
)

bootContext: Compute.bootContext & {
	app: west: App.#Admin
}
