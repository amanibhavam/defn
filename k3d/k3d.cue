package k3d

import (
    "github.com/defn/boot/k3d"
)

#BootContext: {
    k3d.#K3D
}

bootContext: #BootContext

app: [string]: {...}

bootContext: "app": app
