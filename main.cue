package defn

import (
	"github.com/defn/boot/project"
	"github.com/defn/boot/devcontainer"
)

#BootContext: ctx={
	project.#Project
	devcontainer.#DevContainer
}

bootContext: #BootContext & {
	codeowners: ["@jojomomojo", "@amanibhavam"]
}
