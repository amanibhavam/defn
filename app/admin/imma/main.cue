package imma

import (
	Compute "github.com/amanibhavam/defn/compute/imma"
	App "github.com/amanibhavam/defn/app/admin"
)

bootContext: Compute.bootContext & {
	app: imma: App.#Admin
}
