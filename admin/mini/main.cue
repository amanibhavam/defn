package mini

import (
	Compute "github.com/amanibhavam/defn/compute/mini"
	App "github.com/amanibhavam/defn/admin"
)

bootContext: Compute.bootContext & {
	app: mini: App.#Admin
}
