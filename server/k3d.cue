package k3d

import (
    "github.com/defn/boot/k3d"
)

#BootContext: {
    k3d.#K3D
}

bootContext: #BootContext

app: [aname=string]: app_name: aname

bootContext: "app": app
