package zero

import (
	Compute "github.com/amanibhavam/defn/compute/zero"
	App "github.com/amanibhavam/defn/app/admin"
)

bootContext: Compute.bootContext & {
	app: zero: App.#Admin
}
