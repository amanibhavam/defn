package west

import (
	Compute "github.com/amanibhavam/defn/compute/west"
	App "github.com/amanibhavam/defn/app/admin"
)

bootContext: Compute.bootContext & {
  app: west: App.#Admin
}
