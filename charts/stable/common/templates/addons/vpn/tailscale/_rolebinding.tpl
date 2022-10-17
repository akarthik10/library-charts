{{/*
Tailscale Role Binding
*/}}
{{- define "common.addon.tailscale.rolebinding" -}}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: tailscale-{{ include "common.names.fullname" $ }}
subjects:
- kind: ServiceAccount
  name: tailscale-{{ include "common.names.fullname" $ }}
roleRef:
  kind: Role
  name: tailscale-{{ include "common.names.fullname" $ }}
  apiGroup: rbac.authorization.k8s.io
{{- end -}}
