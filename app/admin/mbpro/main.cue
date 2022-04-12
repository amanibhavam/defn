package mbpro

import (
	Compute "github.com/amanibhavam/defn/compute/mbpro"
	App "github.com/amanibhavam/defn/app/admin"
)

bootContext: Compute.bootContext & {
	app: mbpro: App.#Admin
}
