package app

#AdminApp: {
	app_name:  string

	output: {
		namespace: "\(app_name)": {
			apiVersion: "v1"
			kind:       "Namespace"
			metadata: name: "\(app_name)"
		}

		clusterRoleBinding: "\(app_name)": {
			apiVersion: "rbac.authorization.k8s.io/v1"
			kind:       "ClusterRoleBinding"
			metadata: name: "\(app_name)"
			subjects: [{
				kind:      "ServiceAccount"
				namespace: "\(app_name)"
				name:      "default"
			}]
			roleRef: {
				kind:     "ClusterRole"
				name:     "cluster-admin"
				apiGroup: "rbac.authorization.k8s.io"
			}
		}

		pod: "\(app_name)": {
			apiVersion: "v1"
			kind:       "Pod"
			metadata: {
				namespace: "\(app_name)"
				name:      "\(app_name)"
			}
			spec: {
				containers: [{
					name:  "defn"
					image: "defn/dev"
					tty:   true
					volumeMounts: [{
						name:      "docker-sock"
						mountPath: "/var/run/docker.sock"
					}, {
						name:      "password-store"
						mountPath: "/home/ubuntu/.password-store"
					}, {
						name:      "work"
						mountPath: "/workspaces"
					}]
				}]
				volumes: [{
					name: "docker-sock"
					hostPath: path: "/var/run/docker.sock"
				}, {
					name: "password-store"
					hostPath: path: "/mnt/password-store"
				}, {
					name: "work"
					hostPath: path: "/mnt/work"
				}]
			}
		}
	}
}
