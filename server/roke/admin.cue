package k3d

import (
	App "github.com/jojomomojo/defn/app"
)

app: [aname=string]: App.#AdminApp & {
	app_name: aname
}
