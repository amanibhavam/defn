package mbpro

import (
	Compute "github.com/amanibhavam/defn/compute/mbpro"
	App "github.com/amanibhavam/defn/admin"
)

bootContext: Compute.bootContext & {
	app: mbpro: App.#Admin
}
