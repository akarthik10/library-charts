{{/*
Tailscale Role
*/}}
{{- define "common.addon.tailscale.role" -}}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: tailscale-{{ include "common.names.fullname" $ }}
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["secrets"]
  # Create can not be restricted to a resource name.
  verbs: ["create"]
- apiGroups: [""] # "" indicates the core API group
  resourceNames: ["tailscale-{{ include "common.names.fullname" $ }}"]
  resources: ["secrets"]
  verbs: ["get", "update"]
{{- end -}}
